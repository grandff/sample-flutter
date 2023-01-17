import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:practice_flutter3/screens/home_screen.dart';

void main() async {
  // env 파일 경로 설정
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: HomeScreen(),
    );
  }
}
