import 'package:flutter/material.dart';
import 'package:practice_flutter3/services/weather_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // 오늘의 날씨 목록 조회
  final Future<String> weathers = WeatherService.getTodayWeathers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Center(
          child: Text("The Weather's Time"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
            ),
          ),
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
