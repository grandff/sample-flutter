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
  List<String> historyList = [];

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
      historyList = [];
    });
  }

  // 타이머 일시정지
  void onPause() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  // 5초 추가
  void addTenSeconds() {
    totalMilieSeconds = totalMilieSeconds + 500;
    if (totalMilieSeconds >= threeMinutes) {
      totalMilieSeconds = 0;
      totalProgress = 0;
    }

    setState(() {
      totalCounts = totalCounts + 1;
    });
  }

  // 현재 시간 기록 후 다시 시작
  void addHistory() {
    historyList.add(format(totalMilieSeconds));
    totalMilieSeconds = 0;
    totalProgress = 0;

    setState(() {
      totalCounts = totalCounts + 1;
    });
  }

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
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 250,
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
          SizedBox(
            height: 120,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: !isRunning ? onStart : onPause,
                    iconSize: 80,
                    icon: Icon(
                      !isRunning
                          ? Icons.play_circle_outline_outlined
                          : Icons.pause_circle_outline_outlined,
                    ),
                  ),
                  const SizedBox(width: 50),
                  IconButton(
                    onPressed: onStop,
                    iconSize: 80,
                    icon: const Icon(
                      Icons.stop_circle_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              // 아래 버튼들 위젯으로 빼기
              GestureDetector(
                onTap: addTenSeconds,
                child: Container(
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
                  child: const Text("5초 추가"),
                ),
              ),
              GestureDetector(
                onTap: addHistory,
                child: Container(
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
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [const Text("전체 횟수 : "), Text('$totalCounts')],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 10.0,
              trackVisibility: true,
              child: ListView.builder(
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      historyList[index],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
