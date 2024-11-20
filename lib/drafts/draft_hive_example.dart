import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spaced/spaced.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');

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
  String? name;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('myBox');

    return Scaffold(
      appBar: AppBar(title: const Text('Hive CE Example')),
      body: SpacedColumn(
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              box.put('name', name);
            },
            child: const Text('Add Name'),
          ),
          ValueListenableBuilder(
            valueListenable: box.listenable(keys: ['name']),
            builder: (BuildContext context, Box box, widget) {
              return Text('Name: ${box.get('name')}');
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
    final box = Hive.box('myBox');

    return ValueListenableBuilder(
      valueListenable: box.listenable(keys: ['name']),
      builder: (BuildContext context, Box nameBox, child) {
        return Text('${nameBox.get('name')}');
      },
    );
  }
}
