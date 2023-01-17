import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_flutter3/models/location/geocoding_model.dart';
import 'package:practice_flutter3/services/geocoding_service.dart';
import 'package:practice_flutter3/services/geolocator_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<num> latitude = ValueNotifier<num>(0);
  ValueNotifier<num> longitude = ValueNotifier<num>(0);
  late Future<Position> nowLocation; // 현재 위치 정보 불러오기
  late Future<RegionCodeModel> nowAddress; // 현재 주소명

  // 메인화면 초기화
  void initAddressName() {
    // 좌표 정보 확인
    // 비정상 좌표 일 경우..
    nowLocation
        .then((value) => {
              latitude.value = value.latitude,
              longitude.value = value.longitude,
            })
        .catchError((error) {
      // 임의값으로 수정
      latitude.value = 35.0224527777778;
      longitude.value = 126.789441666667;
    });

    // 한국이 아닌 경우에도 임의값으로 수정 37. 127 범위
    if (!(longitude.value >= 125 && longitude.value < 128)) {
      latitude.value = 35.0224527777778;
      longitude.value = 126.789441666667;
    }

    nowAddress = GeocodingService.coord2region(latitude.value, longitude.value);
    nowAddress.then((value) => print(value.addressName));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowLocation = GeolocateService.determinePosition(); // 현재 위치 정보 조회
    initAddressName();

    // 카카오좌표 도전.. 아님말고 어쩌지 ㅅㅂ
    // 그 정보로 날씨를 가져와야함
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Center(
          child: Text("The Weather's Time"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: FutureBuilder(
                      future: nowAddress,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.addressName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: const Text('위젯'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.red,
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
