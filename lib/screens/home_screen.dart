import 'package:flutter/material.dart';
import 'package:sample_flutter/models/webtoon_model.dart';
import 'package:sample_flutter/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // api를 통해 받아올 데이터 목록
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  // http 요청을 기다리는 함수
  void waitForWebtoons() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebtoons();
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons);
    print(isLoading);
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
    );
  }
}
