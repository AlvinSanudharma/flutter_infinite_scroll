import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll/app.dart';

void main() {
  runApp(const App());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
