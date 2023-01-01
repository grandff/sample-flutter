import 'package:flutter/material.dart';
import 'package:sample_flutter/models/webtoon_model.dart';
import 'package:sample_flutter/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, // 앱바 하단의 음영을 사라지게함. 높을 수록 음영이 진해짐
        backgroundColor: Colors.white, // 배경색
        foregroundColor: Colors.green, // 글자색
        title: const Center(
          child: Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        // future builder를 통해 데이터 fetch 구현
        future: webtoons, // 데이터 fetch 후 받아질 데이터 형태
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 데이터를 다 받아왔으면
            return const Text("There is data!");
          }

          return const Text('Loading...');
        },
      ),
    );
  }
}
