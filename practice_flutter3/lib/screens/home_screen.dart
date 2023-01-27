import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_flutter3/models/location/geocoding_model.dart';
import 'package:practice_flutter3/screens/week_screen.dart';
import 'package:practice_flutter3/services/geocoding_service.dart';
import 'package:practice_flutter3/services/geolocator_service.dart';
import 'package:practice_flutter3/services/now_weather_service.dart';
import 'package:practice_flutter3/services/weather_service.dart';
import 'package:practice_flutter3/services/wrn_info_service.dart';
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
  late Future<Map<String, dynamic>> wrnInfo; // 기상 특보 현황
  ValueNotifier<String> region1 = ValueNotifier<String>("");
  ValueNotifier<String> region2 = ValueNotifier<String>("");
  ValueNotifier<String> region3 = ValueNotifier<String>("");

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
    nowAddress.then((value) {
      region1.value = value.region1depthName;
      region2.value = value.region2depthName;
      region3.value = value.region3depthName;
    });

    todayWeather = NowWeatherService.getTodayWeatherInfo(
        latitude.value, longitude.value); // 오늘 날씨

    todayWeatherList = WeatherService.getTodayWeathers(
        latitude.value, longitude.value); // 오늘,내일,모레 날씨 정보 조회

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
    wrnInfo = WrnInfoService.getPwnStatus(); // 기상 특보 현황
  }

  // 위치 재설정 안내 토스트 메시지
  void showRelocationToast() {
    Fluttertoast.showToast(
      msg: "위치를 재설정합니다.",
      gravity: ToastGravity.BOTTOM,
      fontSize: 15,
      backgroundColor: Colors.white,
      textColor: Colors.grey,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void changeToKoreaLocation() {
    // 한국이 아닌 경우에도 임의값으로 수정 37. 127 범위
    if (!(longitude.value >= 125 && longitude.value < 128)) {
      latitude.value = 35.0224527777778;
      longitude.value = 126.789441666667;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: FutureBuilder(
          future: nowAddress,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                '${snapshot.data!.region1depthName} ${snapshot.data!.region2depthName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SpoqaSans',
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        leading: IconButton(
          onPressed: () {
            print('기상특보로 넘어갈 화면임');
          },
          icon: const Icon(
            Icons.notifications_on_outlined,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // 위치 재설정
              showRelocationToast();
              nowLocation = GeolocateService.determinePosition(); // 현재 위치 정보 조회
              initAddressName();
            },
            icon: const Icon(
              Icons.my_location_rounded,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: todayWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var weatherData = snapshot.data!;
                    return SizedBox(
                      width: 300,
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
                                      widthVal: 80,
                                      heightVal: 80,
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

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '오늘의 날씨',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SpoqaSans',
                        fontSize: 17,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        changeToKoreaLocation();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => WeekScreen(
                                  latitude: latitude.value,
                                  longitude: longitude.value,
                                  region1depthName: region1.value,
                                  region2depthName: region2.value,
                                  region3depthName: region3.value,
                                )),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '다음주 날씨',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SpoqaSans',
                              color: Colors.purple.shade600,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.purple.shade600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 160,
              // 내일하고 모레 데이터는 일단 받아올수있음
              // 그 넘어서 데이터는 중기 데이터를 사용해야할듯함!
              child: FutureBuilder(
                future: todayWeatherList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var weather = snapshot.data![index];
                                var weatherTime =
                                    "${weather['TIME'].toString().substring(0, 2)}:${weather['TIME'].toString().substring(2, 4)}";
                                var nowTimeAreaCheck = DateUtility()
                                    .checkNowTimeFlag(weather['TIME']
                                        .toString()
                                        .substring(0, 2));
                                var imgNameInList =
                                    SkyUtility.changeToImgFileName(
                                        weather['SKY'], weather['PTY']);
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: nowTimeAreaCheck
                                        ? const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                                Color(0xFFA18CD1),
                                                Color(0xFFFBC2EB),
                                              ])
                                        : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        weather['TMP'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'SpoqaSans',
                                          fontWeight: FontWeight.w600,
                                          color: nowTimeAreaCheck
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      FutureBuilder(
                                        future: imgNameInList,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return SkyWidget(
                                              imgFileName:
                                                  snapshot.data!.toString(),
                                              widthVal: 40,
                                              heightVal: 40,
                                            );
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                      Text(
                                        weatherTime,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'SpoqaSans',
                                          color: nowTimeAreaCheck
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
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
        vertical: 12,
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
              const SizedBox(
                height: 5,
              ),
              const Text(
                "풍속",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'SpoqaSans',
                  color: Colors.grey,
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
              const SizedBox(
                height: 5,
              ),
              const Text(
                "강수량",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'SpoqaSans',
                  color: Colors.grey,
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
              const SizedBox(
                height: 5,
              ),
              const Text(
                "습도",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'SpoqaSans',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
