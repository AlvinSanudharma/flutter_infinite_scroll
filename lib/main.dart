import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_scroll/app.dart';
import 'package:flutter_infinite_scroll/simple_bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
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
