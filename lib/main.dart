import 'package:flutter/material.dart';
import 'package:sample_flutter/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App(
      {super.key}); // key를 stateless widget의 슈퍼클래스에 보내는거임. 식별자 역할을 한다고만 생각하면 됨.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
