import 'package:flutter/material.dart';
import 'package:practice_flutter2/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          backgroundColor: Colors.white,
          cardColor: const Color(0xFFE68E5C),
        ),
        home: const HomeScreen());
  }
}
