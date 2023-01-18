import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_flutter3/models/location/geocoding_model.dart';
import 'package:practice_flutter3/services/geocoding_service.dart';
import 'package:practice_flutter3/services/geolocator_service.dart';
import 'package:practice_flutter3/services/weather_service.dart';

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
  late Future<Map<String, dynamic>> nowWeather; // 오늘 날씨

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

    nowAddress = GeocodingService.coord2region(
        latitude.value, longitude.value); // 현재 위치 변환
    nowWeather = WeatherService.getTodayWeathers(
        latitude.value, longitude.value); // 현재 날씨 정보 조회
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowLocation = GeolocateService.determinePosition(); // 현재 위치 정보 조회
    initAddressName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: FutureBuilder(
            future: nowAddress,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data!.addressName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SpoqaSans',
                    ),
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          )),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder(
                future: nowWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var weatherData = snapshot.data!;
                    return Column(
                      children: [
                        Text(weatherData['TMP']),
                        Text(weatherData['WSD']),
                        Text(weatherData['SKY']),
                        Text(weatherData['PTY']),
                        Text(weatherData['POP']),
                        Text(weatherData['PCP']),
                        Text(weatherData['REH']),
                        Text(weatherData['SNO']),
                        Text(weatherData['WSD']),
                      ],
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          Container(
            height: 170,
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
