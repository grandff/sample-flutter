import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_flutter3/services/geolocator_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late num latitude; // 위도
  late num longitude; // 경도
  late Future<Position> nowLocation; // 현재 위치 정보 불러오기

  // 메인화면 초기화
  void main() {
    // 좌표 정보 확인
    // 비정상 좌표 일 경우..
    nowLocation
        .then((value) => {
              latitude = value.latitude,
              longitude = value.longitude,
            })
        .catchError((error) {
      // 임의값으로 수정
      latitude = 35.022;
      longitude = 126.789;
    });

    // 한국이 아닌 경우에도 임의값으로 수정 37. 127 범위
    if (!(longitude >= 125 && longitude < 128)) {
      latitude = 35.022;
      longitude = 126.789;
    }

    print("좌표 : $latitude, $longitude");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowLocation = GeolocateService.determinePosition(); // 현재 위치 정보 조회

    // 카카오좌표 도전.. 아님말고 어쩌지 ㅅㅂ
    // 그 정보로 날씨를 가져와야함

    main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Center(
          child: Text("The Weather's Time"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
            ),
          ),
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
