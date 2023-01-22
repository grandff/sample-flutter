import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_flutter3/models/location/geocoding_model.dart';
import 'package:practice_flutter3/services/geocoding_service.dart';
import 'package:practice_flutter3/services/geolocator_service.dart';
import 'package:practice_flutter3/services/now_weather_service.dart';
import 'package:practice_flutter3/services/weather_service.dart';
import 'package:practice_flutter3/utility/get_today.dart';
import 'package:practice_flutter3/utility/sky_text.dart';
import 'package:practice_flutter3/widgets/sky_widget.dart';

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
  late Future<Map<String, dynamic>> todayWeather; // 오늘 날씨
  late Future<List<Map<String, dynamic>>>
      todayWeatherList; // 오늘 시간대별 날씨 + 내일, 모레 날씨
  late Future<String> imgFileName;

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

    todayWeather = NowWeatherService.getTodayWeatherInfo(
        latitude.value, longitude.value); // 오늘 날씨

    todayWeatherList = WeatherService.getTodayWeathers(
        latitude.value, longitude.value); // 오늘,내일,모레 날씨 정보 조회
    print("list : ${todayWeatherList.toString()}");

    // 오늘 날씨 이미지파일 설정
    todayWeather.then((value) {
      imgFileName = SkyUtility.changeToImgFileName(value['SKY'], value['PTY']);
    });
  }

  @override
  void initState() {
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
                    '${snapshot.data!.region1depthName} ${snapshot.data!.region2depthName}',
                    style: const TextStyle(
                      fontSize: 24,
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
                future: todayWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var weatherData = snapshot.data!;
                    return Container(
                      width: 300,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      decoration: const BoxDecoration(
                          /*border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.amber,*/
                          /*gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFA18CD1),
                                Color(0xFFFBC2EB),
                              ]),*/
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${weatherData['T1H']}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 45,
                                      fontFamily: 'SpoqaSans',
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: nowAddress,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.region3depthName,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'SpoqaSans',
                                          ),
                                        );
                                      }
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                ],
                              ),
                              FutureBuilder(
                                future: imgFileName,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return SkyWidget(
                                      imgFileName: snapshot.data!.toString(),
                                    );
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${DateUtility().getDayOfWeek()},${DateUtility().getNowTime()} ",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'SpoqaSans',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          WeatherDetailInfo(weatherData: weatherData),
                        ],
                      ),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          Container(
            height: 170,
            // 내일하고 모레 데이터는 일단 받아올수있음
            // 그 넘어서 데이터는 중기 데이터를 사용해야할듯함!
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

class WeatherDetailInfo extends StatelessWidget {
  const WeatherDetailInfo({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final Map<String, dynamic> weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 25,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(5, 5),
            color: Colors.grey.withOpacity(0.4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Image(
                image: AssetImage("assets/images/info/info_wind.png"),
                width: 30,
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                weatherData['WSD'],
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'SpoqaSans',
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Image(
                image: AssetImage("assets/images/info/info_pre.png"),
                width: 30,
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                (weatherData['RN1'] == "강수없음mm" ? "강수없음" : weatherData['RN1']),
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'SpoqaSans',
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Image(
                image: AssetImage("assets/images/info/info_humi.png"),
                width: 30,
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                weatherData['REH'],
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'SpoqaSans',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
