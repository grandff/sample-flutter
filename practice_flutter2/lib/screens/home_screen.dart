import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const oneMinutes = 60;
  int totalSeconds = oneMinutes;
  int totalPomodoros = 0;
  double totalProgress = 0.0;
  bool isRunning = false;
  late Timer timer;

  // 타이머 포맷
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '시계',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              // 이거 위젯으로 빼기
              alignment: Alignment.bottomCenter,
              child: CircularPercentIndicator(
                animation: true,
                radius: 140.0, // 이게 크기임..
                lineWidth: 15,
                percent: totalProgress,
                center: Text(format(totalSeconds),
                    style: const TextStyle(
                      fontSize: 60,
                    )),
                backgroundColor: Colors.grey,
                progressColor: Colors.orange,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_circle_outline_outlined,
                          size: 80,
                        )),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.stop_circle_outlined,
                          size: 80,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 아래 버튼들 위젯으로 빼기
                  Container(
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Text("1분 추가"),
                  ),
                  Container(
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Text("기록하기"),
                  ),
                  Container(
                    child: Column(
                      children: const [Text("전체 횟수"), Text("0")],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
