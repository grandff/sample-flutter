import 'dart:convert';

import 'package:practice_flutter3/models/getVilageFcst/fcst_model.dart';
import 'package:practice_flutter3/utility/get_today.dart';
import 'package:http/http.dart' as http;

// 초단기예보로 처리
// 초단기예보는 오늘날짜인 것들만 리턴하기
class NowWeatherService {
  final num latitude;
  final num longitude;

  NowWeatherService({
    required this.latitude,
    required this.longitude,
  });

  // 날씨 요청 API (초단기예보조회)
  static const String baseUrl =
      "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst";

  // 날씨 요청 API Key
  static const String apiKey =
      "yXugn7gIb5dEF5jMX1UjuV4qiy%2Bczf9hX3GZhu%2Fp3kxVI9JbMCvBGPHpKVp5QkAOllYDPlfSnSw0CDX7ZGGYsg%3D%3D";

  // 오늘 날씨
  static Future<Map<String, dynamic>> getTodayWeatherInfo(
      latitude, longitude) async {
    Map<String, dynamic> weatherInstances = {};

    // 날짜는 오늘날짜
    // 1시간 단위임
    var today = DateUtility().getToday();
    var todayHour = DateUtility().getTimeForTodayWeather();

    // 좌표 소수점 버리기
    var nx = latitude.floor();
    var ny = longitude.floor();

    // 날씨 api call
    final url = Uri.parse(
        '$baseUrl?serviceKey=$apiKey&numOfRows=1000&pageNo=1&dataType=JSON&base_date=$today&base_time=$todayHour&nx=$nx&ny=$ny');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = FcstModel.fromJson(fullData);
      final FcstItemsModel weatherList = parsingData.response.body.items;

      for (var weather in weatherList.item) {
        // 오늘 날짜 인것들만 저장
        if (weather.fcstDate == today) {
          if (weather.category == "T1H") {
            // 기온
            weatherInstances['T1H'] = "${weather.fcstValue}℃";
          } else if (weather.category == "RN1") {
            // 1시간 강수량
            weatherInstances['RN1'] = "${weather.fcstValue}mm";
          } else if (weather.category == "SKY") {
            // 하늘상태
            // 1 맑음
            // 3 구름많음
            // 4 흐림
            weatherInstances['SKY'] = weather.fcstValue;
          } else if (weather.category == "PTY") {
            // 강수형태
            /*
              (초단기) 없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7) 
              (단기) 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4) 
            */
            weatherInstances['PTY'] = weather.fcstValue;
          } else if (weather.category == "REH") {
            // 습도
            weatherInstances['REH'] = "${weather.fcstValue}%";
          } else if (weather.category == "WSD") {
            // 풍속
            weatherInstances['WSD'] = "${weather.fcstValue}m/s";
          } else if (weather.category == "VEC") {
            // 풍향
            weatherInstances['VEC'] = "${weather.fcstValue}deg";
          }
        }
      }

      return weatherInstances;
    }

    throw Error();
  }
}
