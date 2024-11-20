import 'package:example_hive/services/hive_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spaced/spaced.dart';

import '../constants/app_constants.dart';
import '../widgets/draft_hive_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Use TextEditingController instead of String for better control
  final TextEditingController _controller = TextEditingController();
  // Create a single listenable instance
  late final ValueListenable<Box> _nameListenable;

  @override
  void initState() {
    super.initState();
    _nameListenable = HiveService.getNameListenable();
    // Initialize controller with existing value
    _controller.text = HiveService.getName();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveName() {
    HiveService.saveName(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive CE Example')),
      body: SpacedColumn(
        spacing: 20,
        children: [
          const SizedBox.square(dimension: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onSubmitted: (str) => _saveName,
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _saveName,
            child: const Text('Add Name'),
          ),
          ValueListenableBuilder(
            valueListenable: _nameListenable,
            builder: (context, Box box, _) {
              return Text(
                'Name: ${box.get(AppConstants.kNameKey, defaultValue: '')}',
                style: Theme.of(context).textTheme.bodyLarge,
              );
            },
          ),
          const DraftHiveText(),
        ],
      ),
    );
  }
}
