import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes; // 25분을 초로 변경
  int totalPomodoros = 0;
  bool isRunning = false;
  late Timer timer; // 사용자가 버튼을 누를떄만 타이머가 생성되게 할거임

  // 1초마다 홈스크린의 setState를 변경해주는 함수
  void onTick(Timer timer) {
    // 타이머가 다되면 현재 뽀모도로 갯수를 상승
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {}
    setState(() {
      totalSeconds = totalSeconds - 1;
    });
  }

  // 타이머 포맷 설정
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  // 버튼 클릭 시 타이머 시작
  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    ); // dart에 내장되어있는 Timer 함수 사용

    setState(() {
      isRunning = true;
    });
  }

  // 타이머를 멈추는 역할
  void onPausePressed() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  // 타이머 재시작
  void onRestartPressed() {
    setState(() {
      isRunning = false;
      totalPomodoros = 0;
      totalSeconds = twentyFiveMinutes;
    });
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor, // main에서 설정한 배경화면 가져옴
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment:
                  Alignment.bottomCenter, // 텍스트가 디바이스 최상단에 가는 현상을 막기 위해 정렬처리
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    // 시작버튼
                    color: Theme.of(context).cardColor,
                    iconSize: 120,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline),
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                  ),
                  IconButton(
                    // 재시작버튼
                    color: Theme.of(context).cardColor,
                    iconSize: 120,
                    icon: const Icon(Icons.stop_circle_outlined),
                    onPressed: onRestartPressed,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              // 하단 전체를 감싸주기 위해 Row로 컨테이너를 감싸줌
              children: [
                Expanded(
                  // Row로 디바이스 가로 전체를 감싸주는 위젯
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
