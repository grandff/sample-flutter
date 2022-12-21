import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Practice',
        home: Scaffold(
          backgroundColor: const Color(0xFFFEF970),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // 상단 버튼 바
                Row(
                  children: [
                    // button 1
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    // button 2
                    Container(
                      decoration: const BoxDecoration(color: Colors.black),
                    )
                  ],
                ),
                // 중간 공간
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
}
