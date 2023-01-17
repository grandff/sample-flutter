import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_flutter3/services/geocoding_service.dart';
import 'package:practice_flutter3/services/geolocator_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //num latitude = 0; // 위도
  //num longitude = 0; // 경도
  ValueNotifier<num> latitude = ValueNotifier<num>(0);
  ValueNotifier<num> longitude = ValueNotifier<num>(0);
  late Future<Position> nowLocation; // 현재 위치 정보 불러오기
  late Future<String> nowAddress; // 현재 주소명

  // 메인화면 초기화
  void main() {
    // 좌표 정보 확인
    // 비정상 좌표 일 경우..
    nowLocation
        .then((value) => {
              latitude.value = value.latitude,
              longitude.value = value.longitude,
            })
        .catchError((error) {
      // 임의값으로 수정
      latitude.value = 35.022452;
      longitude.value = 126.789441;
    });

    // 한국이 아닌 경우에도 임의값으로 수정 37. 127 범위
    if (!(longitude.value >= 125 && longitude.value < 128)) {
      latitude.value = 35.022452;
      longitude.value = 126.789441;
    }

    print("좌표 : $latitude, $longitude");

    nowAddress = GeocodingService.coord2region(latitude.value, longitude.value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowLocation = GeolocateService.determinePosition(); // 현재 위치 정보 조회
    //nowAddress = GeocodingService.coord2region(latitude.value, longitude.value);
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
