import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spaced/spaced.dart';

class DraftConstants {
  static const String boxName = 'myBox';
  static const String boxKeyName = 'name';
}

late final Box _box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  _box = await Hive.openBox(DraftConstants.boxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = _box.get(DraftConstants.boxKeyName, defaultValue: '');
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive CE Example')),
      body: SpacedColumn(
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: textEditingController,
              onChanged: (val) {
                _box.put(DraftConstants.boxKeyName, textEditingController.text);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _box.put(DraftConstants.boxKeyName, textEditingController.text);
            },
            child: const Text('Add Name'),
          ),
          ValueListenableBuilder(
            valueListenable: _box.listenable(keys: [DraftConstants.boxKeyName]),
            builder: (BuildContext context, Box box, widget) {
              return Text('Name: ${box.get(DraftConstants.boxKeyName)}');
            },
          ),
          const DraftHiveText(),
        ],
      ),
    );
  }
}

class DraftHiveText extends StatelessWidget {
  const DraftHiveText({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(DraftConstants.boxName);

    return ValueListenableBuilder(
      valueListenable: box.listenable(keys: [DraftConstants.boxKeyName]),
      builder: (BuildContext context, Box nameBox, child) {
        return Text('box: ${box.values}');
      },
    );
  }
}
