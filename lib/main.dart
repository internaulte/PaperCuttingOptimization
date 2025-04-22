import 'package:flutter/material.dart';

import 'injection.dart' as di;
import 'presentation/screens/home_screen.dart';

void main() {
  di.setupDependencies();
  runApp(const PaperCuttingOptimizationApp());
}

class PaperCuttingOptimizationApp extends StatelessWidget {
  const PaperCuttingOptimizationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paper Cutting Optimization',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
