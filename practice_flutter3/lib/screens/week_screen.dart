import 'package:flutter/material.dart';
import 'package:practice_flutter3/models/code/weather_regId_enum.dart';
import 'package:practice_flutter3/models/code/weather_regarea_enum.dart';
import 'package:practice_flutter3/services/weather_service.dart';
import 'package:practice_flutter3/services/week_weather_service.dart';
import 'package:practice_flutter3/utility/get_today.dart';
import 'package:practice_flutter3/utility/sky_text.dart';
import 'package:practice_flutter3/widgets/sky_widget.dart';
import 'package:practice_flutter3/widgets/weatherinfo_widget.dart';
import 'package:practice_flutter3/widgets/weekWeather_widget.dart';

class WeekScreen extends StatefulWidget {
  // 날씨 조회에 필요한 좌표값만 받아오기
  final num latitude, longitude;

  // 중기예보는 코드로 측정지역 코드로 변환해야하므로 지역명을 받아와야함
  final String region1depthName;
  final String region2depthName;
  final String region3depthName;

  const WeekScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.region1depthName,
    required this.region2depthName,
    required this.region3depthName,
  });

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  late Future<List<Map<String, dynamic>>> weatherList;
  late Future<Map<String, dynamic>> nextWeekWeatherInfo;
  late Future<String> nextImgFileName;
  late Future<String> afterImgFileName;
  late Future<String> nextSkyStatusStr;
  late Future<String> afterSkyStatusStr;

  // 중기기온예보에 사용할 측정소 아이디값 가져오기
  String getWeekWeatherRegId(String region1, String region2, String region3) {
    /*
    1. region1,region2,region3을 순서대로 넣은 리스트를 만든다.
    2. map 함수를 이용하여 region1,region2,region3을 순서대로 넣은 리스트를 각각 WeatherRegId.getByArea(region).code로 변환한다.
    3. firstWhere를 이용하여 첫번째로 "none"이 아닌 값을 찾고, 그렇지 않다면 "11B10101"을 반환한다.
    */
    return [region3, region2, region1]
        .map((region) => WeatherRegId.getByArea(region).code)
        .firstWhere((regId) => regId != "none", orElse: () => "11B10101");
  }

  // 중기전망예보에 사용할 측정소 아이디값 가져오기
  String getWeekWeatherRegArea(String region1) {
    return WeatherRegareaEnum.getByArea(region1).code;
  }

  @override
  void initState() {
    super.initState();
    // 중기예보를 위한 측정소 아이디 설정
    String regArea = getWeekWeatherRegArea(widget.region1depthName);
    String regId = getWeekWeatherRegId(widget.region1depthName,
        widget.region2depthName, widget.region3depthName);

    // 내일, 모레 날씨 가져오기 (기상조회)
    weatherList =
        WeatherService.getNextDayWeathers(widget.latitude, widget.longitude);
    // 그다음 날씨조회 (중기조회)
    nextWeekWeatherInfo =
        WeekWeatherService.getNextWeekWeathers(regArea, regId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '다음주 날씨',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'SpoqaSans',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
          child: Column(
            children: [
              FutureBuilder(
                future: weatherList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> nextWeatherInfo = {};
                    Map<String, dynamic> dayAfterWeatherInfo = {};
                    var weatherList = snapshot.data!;
                    String nextDay = DateUtility().getNextDay();
                    String afterDay = DateUtility().getDayAfter();
                    String nowTime = DateUtility().getTimeForNow();
                    late String nextTmnTmp = "";
                    late String nextTmxTmp = "";
                    late String afterTmnTmp = "";
                    late String afterTmxTmp = "";

                    // 내일 날씨는 현재 시간 기준으로 제공
                    // 최저, 최고기온 제공
                    for (var weather in weatherList) {
                      if (weather['DATE'] == nextDay &&
                          weather['TIME'] == nowTime) {
                        nextWeatherInfo = weather;
                      }

                      if (weather['DATE'] == afterDay &&
                          weather['TIME'] == nowTime) {
                        dayAfterWeatherInfo = weather;
                      }

                      // 최저기온
                      if (weather['TMN'].toString().isNotEmpty &&
                          weather['TMN'] != null) {
                        if (weather['DATE'] == nextDay) {
                          nextTmnTmp = weather['TMN'];
                        }

                        if (weather['DATE'] == afterDay) {
                          afterTmnTmp = weather['TMN'];
                        }
                      }

                      // 최고기온
                      if (weather['TMX'].toString().isNotEmpty &&
                          weather['TMX'] != null) {
                        if (weather['DATE'] == nextDay) {
                          nextTmxTmp = weather['TMX'];
                        }

                        if (weather['DATE'] == afterDay) {
                          afterTmxTmp = weather['TMX'];
                        }
                      }
                    }

                    // 이미지파일 설정
                    nextImgFileName = SkyUtility.changeToImgFileName(
                        nextWeatherInfo['SKY'], nextWeatherInfo['PTY']);
                    // 모레 날씨 이미지 파일 설정
                    afterImgFileName = SkyUtility.changeToImgFileName(
                        dayAfterWeatherInfo['SKY'], dayAfterWeatherInfo['PTY']);
                    // 날씨 요약 텍스트로 변경
                    nextSkyStatusStr = SkyUtility.changeSkyStr(
                        nextWeatherInfo['SKY'], nextWeatherInfo['PTY']);
                    // 모레 날씨 요약 텍스트로 변경
                    afterSkyStatusStr = SkyUtility.changeSkyStr(
                        dayAfterWeatherInfo['SKY'], dayAfterWeatherInfo['PTY']);

                    return Column(
                      children: [
                        Container(
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
                            children: [
                              FutureBuilder(
                                future: nextImgFileName,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 15, 0),
                                      child: SkyWidget(
                                        imgFileName: snapshot.data!.toString(),
                                        widthVal: 80,
                                        heightVal: 80,
                                      ),
                                    );
                                  }

                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '내일 날씨',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: 'SpoqaSans',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        nextWeatherInfo['TMP'],
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontFamily: 'SpoqaSans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      FutureBuilder(
                                        future: nextSkyStatusStr,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'SpoqaSans',
                                              ),
                                            );
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '$nextTmxTmp / $nextTmnTmp',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SpoqaSans',
                                      color: Colors.grey,
                                      //fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        WeatherDetailInfo(
                          wsd: nextWeatherInfo['WSD'],
                          pcp: nextWeatherInfo['PCP'],
                          reh: nextWeatherInfo['REH'],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        WeekWeather(
                          dayVal: nextDay,
                          imgFileName: nextImgFileName,
                          tmxTmp: nextTmxTmp,
                          tmnTmp: nextTmnTmp,
                        ),
                        WeekWeather(
                          dayVal: afterDay,
                          imgFileName: afterImgFileName,
                          tmxTmp: afterTmxTmp,
                          tmnTmp: afterTmnTmp,
                        ),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: nextWeekWeatherInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var totalData = snapshot.data!;
                    var weatherData = totalData['weather'];
                    var tempData = totalData['temp'];
                    var timeGubun = DateUtility().getTimeGubun();

                    // 3일 후부터 7일 후 까지 날씨 데이터
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WeekWeather(
                            dayVal: DateUtility().getDurationDay(3),
                            tmxTmp: "${tempData['taMax3']}.0℃",
                            tmnTmp: "${tempData['taMin3']}.0℃",
                            imgFileName: SkyUtility.changeToListImgFileName(
                                timeGubun == "am"
                                    ? weatherData['wf3Am']
                                    : weatherData['wf3Pm'],
                                ""),
                          ),
                          WeekWeather(
                            dayVal: DateUtility().getDurationDay(4),
                            tmxTmp: "${tempData['taMax4']}.0℃",
                            tmnTmp: "${tempData['taMin4']}.0℃",
                            imgFileName: SkyUtility.changeToListImgFileName(
                                timeGubun == "am"
                                    ? weatherData['wf4Am']
                                    : weatherData['wf4Pm'],
                                ""),
                          ),
                          WeekWeather(
                            dayVal: DateUtility().getDurationDay(5),
                            tmxTmp: "${tempData['taMax5']}.0℃",
                            tmnTmp: "${tempData['taMin5']}.0℃",
                            imgFileName: SkyUtility.changeToListImgFileName(
                                timeGubun == "am"
                                    ? weatherData['wf5Am']
                                    : weatherData['wf5Pm'],
                                ""),
                          ),
                          WeekWeather(
                            dayVal: DateUtility().getDurationDay(6),
                            tmxTmp: "${tempData['taMax6']}.0℃",
                            tmnTmp: "${tempData['taMin6']}.0℃",
                            imgFileName: SkyUtility.changeToListImgFileName(
                                timeGubun == "am"
                                    ? weatherData['wf6Am']
                                    : weatherData['wf6Pm'],
                                ""),
                          ),
                          WeekWeather(
                            dayVal: DateUtility().getDurationDay(7),
                            tmxTmp: "${tempData['taMax7']}.0℃",
                            tmnTmp: "${tempData['taMin7']}.0℃",
                            imgFileName: SkyUtility.changeToListImgFileName(
                                timeGubun == "am"
                                    ? weatherData['wf7Am']
                                    : weatherData['wf7Pm'],
                                ""),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
