import 'package:example_hive/widgets/unfocus.dart';
import 'package:flutter/material.dart';

import 'drafts/draft_hive_example.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      // Add these optimizations
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Unfocus(child: child!),
    );
  }
}
