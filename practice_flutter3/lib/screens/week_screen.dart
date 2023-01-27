import 'package:flutter/material.dart';
import 'package:practice_flutter3/services/weather_service.dart';
import 'package:practice_flutter3/utility/get_today.dart';
import 'package:practice_flutter3/utility/sky_text.dart';
import 'package:practice_flutter3/widgets/sky_widget.dart';
import 'package:practice_flutter3/widgets/weatherinfo_widget.dart';

class WeekScreen extends StatefulWidget {
  // 날씨 조회에 필요한 좌표값만 받아오기
  final num latitude, longitude;
  const WeekScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  late Future<List<Map<String, dynamic>>> weatherList;
  late Future<String> nextImgFileName;
  late Future<String> afterImgFileName;
  late Future<String> nextSkyStatusStr;
  late Future<String> afterSkyStatusStr;

  @override
  void initState() {
    super.initState();

    // 내일, 모레 날씨 가져오기 (기상조회)
    weatherList =
        WeatherService.getNextDayWeathers(widget.latitude, widget.longitude);
    // 그다음 날씨조회 (중기조회)
    // 그외 먼가 또 있을까욥?
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
                                  return SkyWidget(
                                    imgFileName: snapshot.data!.toString(),
                                    widthVal: 80,
                                    heightVal: 80,
                                  );
                                }

                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                            Column(
                              children: [
                                const Text('내일 날씨'),
                                Row(
                                  children: [
                                    Text(nextWeatherInfo['TMP']),
                                    FutureBuilder(
                                      future: nextSkyStatusStr,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.toString());
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Text('$nextTmxTmp / $nextTmnTmp'),
                              ],
                            )
                          ],
                        ),
                      ),
                      WeatherDetailInfo(
                        wsd: nextWeatherInfo['WSD'],
                        pcp: nextWeatherInfo['PCP'],
                        reh: nextWeatherInfo['REH'],
                      ),
                      Row(
                        children: [
                          Text(DateUtility().getWeekdayFromString(nextDay)),
                          FutureBuilder(
                            future: nextImgFileName,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SkyWidget(
                                  imgFileName: snapshot.data!.toString(),
                                  widthVal: 30,
                                  heightVal: 30,
                                );
                              }

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          Text(nextTmxTmp),
                          const Text("/"),
                          Text(nextTmnTmp),
                        ],
                      ),
                      const Text('이곳에 모래 날씨가'),
                    ],
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const Text('여기서부터 3일 후 날씨시작'),
          ],
        ),
      ),
    );
  }
}
