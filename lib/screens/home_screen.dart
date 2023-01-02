import 'package:flutter/material.dart';
import 'package:sample_flutter/models/webtoon_model.dart';
import 'package:sample_flutter/services/api_service.dart';
import 'package:sample_flutter/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
          // 데이터를 다 받아왔으면
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ), // listview는 높이가 무제한이므로 column에 안에 쓰려면 높이 제한이 필요함. 여기서 expanded로 감쌈
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal, // 스크롤방향
      itemCount: snapshot.data!.length, // 몇개의 아이템을 빌드할건지
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        // 카드 형태의 디자인
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      // item 마다 separator 추가
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
    );
  }
}
