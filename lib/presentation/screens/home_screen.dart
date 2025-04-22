import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paper Cutting Optimization')),
      body: const Center(
        child: Text(
          'Welcome to the Paper Cutting Optimization App!\n\n'
          'Use the menu to add rectangles and compute layouts.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
