import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // 페이지를 다시 생성하는 것이므로 scaffold를 포함한 구조도 다시 만들어줘야함
    // 사용자 눈에는 페이지 이동처럼 보임
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2, // 앱바 하단의 음영을 사라지게함. 높을 수록 음영이 진해짐
          backgroundColor: Colors.white, // 배경색
          foregroundColor: Colors.green, // 글자색
          title: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  clipBehavior:
                      Clip.hardEdge, // border radius 적용을 위해 clip behavior 적용
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.5),
                        )
                      ]),
                  child: Image.network(thumb),
                ),
              ],
            )
          ],
        ));
  }
}
