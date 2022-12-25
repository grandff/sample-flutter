import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500; // 25분을 초로 변경
  bool isRunning = false;
  late Timer timer; // 사용자가 버튼을 누를떄만 타이머가 생성되게 할거임

  // 1초마다 홈스크린의 setState를 변경해주는 함수
  void onTick(Timer timer) {
    setState(() {
      totalSeconds = totalSeconds - 1;
    });
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
                '$totalSeconds',
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
              child: IconButton(
                color: Theme.of(context).cardColor,
                iconSize: 120,
                icon: Icon(isRunning
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline),
                onPressed: isRunning ? onPausePressed : onStartPressed,
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
                          '0',
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
