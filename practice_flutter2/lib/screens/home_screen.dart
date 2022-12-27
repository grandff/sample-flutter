import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Container(
              // 이거 위젯으로 빼기
              child: CircularPercentIndicator(
                animation: true,
                radius: 140.0, // 이게 크기임..
                lineWidth: 15,
                percent: 0.5,
                center: const Text('20:21'),
                backgroundColor: Colors.grey,
                progressColor: Colors.orange,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.play_circle_outline_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.stop_circle_outlined)),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              child: Column(
                children: [
                  // 아래 버튼들 위젯으로 빼기
                  Container(
                    child: const Text("Add One Minute"),
                  ),
                  Container(
                    child: const Text("History"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
