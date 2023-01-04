import 'package:flutter/material.dart';
import 'package:sample_flutter/models/webtoon_detail_model.dart';
import 'package:sample_flutter/models/webtoon_episode_model.dart';
import 'package:sample_flutter/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // 특정 property를 생성할 떄 기존에 사용하던 property로 접근이 불가능함. 아래 소스는 오류 발생.
  // statelesswidget -> statefulwiget으로 변경
  //Future<WebtoonDetailModel> webtoon = ApiService.getToonsById(widget.id);

  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  // initstate는 build보다 항상 먼저 호출됨!
  @override
  void initState() {
    // initstate에서는 widget.id 접근 가능
    super.initState();
    webtoon = ApiService.getToonsById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

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
              widget
                  .title, // statefulwidget으로 변경하면서 class가 분리 되어 있기 때문에 title만으로는 접근 못함.
              // 따라서 앞에 widget을 붙여줘야함. widget은 부모한테 가라는 의미와 동일함.
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
                Hero(
                  tag: widget.id,
                  child: Container(
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
                    child: Image.network(widget.thumb),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
