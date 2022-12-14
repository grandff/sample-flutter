import 'package:flutter/material.dart';
import 'package:sample_flutter/models/webtoon_detail_model.dart';
import 'package:sample_flutter/models/webtoon_episode_model.dart';
import 'package:sample_flutter/services/api_service.dart';
import 'package:sample_flutter/widgets/episode_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences prefs; // 디바이스 저장소 기능 활용
  bool isLiked = false; // 좋아요 여부

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      // likedToons 안에 해당 웹툰의 좋아요가 있는지 없는지 확인
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      // likedToons 정보가 없다면 디바이스에 새로 생성
      await prefs.setStringList("likedToons", []);
    }
  }

  // initstate는 build보다 항상 먼저 호출됨!
  @override
  void initState() {
    // initstate에서는 widget.id 접근 가능
    super.initState();
    webtoon = ApiService.getToonsById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  // 좋아요 클릭
  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      // 해당 웹툰의 아이디가 등록되어있으면 삭제, 아니면 등록처리
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }

      // 디바이스에 저장
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
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
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline_outlined,
            ),
          )
        ],
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip
                          .hardEdge, // border radius 적용을 위해 clip behavior 적용
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
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                // future builder를 통해 webtoon 정보 받아오기
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    );
                  }

                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          // id 값도 같이 넘겨줌
                          Episode(episode: episode, webtoonId: widget.id)
                      ],
                    );
                  }

                  return const Text("...");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
