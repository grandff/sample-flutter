import 'package:flutter/material.dart';
import 'package:practice_flutter1/screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(
          backgroundColor: const Color(0xFFFEF970),
          cardColor: const Color(0xFF111C2F),
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Color(0xFFAEAE4E),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            headline2: TextStyle(
              color: Color(0xFF121C2E),
              fontSize: 72,
              fontWeight: FontWeight.w400,
            ),
            bodyText1: TextStyle(
              color: Color(0xFF121C2E),
              fontSize: 15,
            ),
            bodyText2: TextStyle(
              color: Color(0xFF121C2E),
              fontSize: 25,
            ),
          )),
      home: const Home(),
    );
  }
}
