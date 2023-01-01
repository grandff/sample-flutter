import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const threeMinutes = 6000;
  int totalMilieSeconds = 0;
  int totalCounts = 0;
  double totalProgress = 0.0;
  bool isRunning = false; // 현재 재생 중인지 일시정지상태인지
  late Timer timer;

  // 타이머 시작
  void onStart() {
    timer = Timer.periodic(const Duration(milliseconds: 10), onTick);

    // isRunning -> true 타이머 시작 알림 처리
    setState(() {
      isRunning = true;
    });
  }

  // 타이머 처리
  void onTick(Timer timer) {
    setState(() {
      totalMilieSeconds = totalMilieSeconds + 1; // 시간 증가
      totalProgress = (totalMilieSeconds / threeMinutes); // progress 증가
    });

    if (totalMilieSeconds == threeMinutes) {
      // 제한시간까지 온 경우 초기화하고 전체 횟수 증가
      totalCounts = totalCounts + 1;
      totalMilieSeconds = 0;
      totalProgress = 0;
      print("time out!!!");
    }
  }

  // 타이머 초기화
  void onStop() {
    timer.cancel();

    setState(() {
      isRunning = false;
      totalCounts = 0;
      totalMilieSeconds = 0;
      totalProgress = 0;
      totalCounts = 0;
    });
  }

  // 타이머 일시정지
  void onPause() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  // 10초 추가
  void addTenSeconds() {
    totalMilieSeconds = totalMilieSeconds + 100;
  }

  // 현재 시간 기록 후 다시 시작
  void addHistory() {}

  // 타이머 포맷
  String format(int milliseconds) {
    var duration = Duration(milliseconds: milliseconds * 10);
    return duration.toString().substring(2, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            '시계',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  format(totalMilieSeconds),
                  style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.orange,
                    value: totalProgress,
                    minHeight: 20,
                  ),
                ),
              ],
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
                        onPressed: !isRunning ? onStart : onPause,
                        icon: Icon(
                          !isRunning
                              ? Icons.play_circle_outline_outlined
                              : Icons.pause_circle_outline_outlined,
                          size: 80,
                        )),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                        onPressed: onStop,
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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: const Text("10초 추가"),
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
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: const Text("기록하기"),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [const Text("전체 횟수 : "), Text('$totalCounts')],
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
