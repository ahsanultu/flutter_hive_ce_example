import 'package:example_hive/screens/home_screen.dart';
import 'package:example_hive/widgets/unfocus.dart';
import 'package:flutter/material.dart';

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
