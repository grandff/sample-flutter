import 'dart:convert';

import 'package:practice_flutter3/models/getVilageFcst/fcst_model.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter3/utility/get_today.dart';

class WeatherService {
  final num latitude;
  final num longitude;

  // 기준시간은 0200 으로 맞춰놓고
  // 오늘날짜에 해당하는거는 보여줘야함 일단..
  WeatherService({
    required this.latitude,
    required this.longitude,
  });

  // 날씨 요청 API (단기예보조회)
  static const String baseUrl =
      "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";

  // serviceKey=인증키&numOfRows=10&pageNo=1

  // 날씨 요청 API Key
  static const String apiKey =
      "yXugn7gIb5dEF5jMX1UjuV4qiy%2Bczf9hX3GZhu%2Fp3kxVI9JbMCvBGPHpKVp5QkAOllYDPlfSnSw0CDX7ZGGYsg%3D%3D";

  // 오늘 전체 날씨 목록 (지역별로..)
  static Future<List<Map<String, dynamic>>> getTodayWeathers(
      latitude, longitude) async {
    print("weather list on !");
    List<Map<String, dynamic>> weatherInstancesList = [];
    Map<String, dynamic> weatherInstances = {};

    // 날짜는 오늘날짜
    var today = DateUtility().getToday();
    // 좌표 소수점 버리기
    var nx = latitude.floor();
    var ny = longitude.floor();

    // 날씨 api call
    final url = Uri.parse(
        '$baseUrl?serviceKey=$apiKey&numOfRows=1000&pageNo=1&dataType=JSON&base_date=$today&base_time=0200&nx=$nx&ny=$ny');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = FcstModel.fromJson(fullData);
      final FcstItemsModel weatherList = parsingData.response.body.items;
      String nowTime = "";
      for (var weather in weatherList.item) {
        // 오늘 기준 날씨만 가져오기
        if (today != weather.fcstDate) continue;

        // 오늘, 내일, 모레 순으로 리스트에 데이터 저장
        if (nowTime != weather.fcstTime && nowTime != "") {
          weatherInstancesList.add(weatherInstances);
          weatherInstances = {};
        }

        nowTime = weather.fcstTime;
        weatherInstances['DATE'] = weather.fcstDate;
        weatherInstances['TIME'] = weather.fcstTime;

        // 카테고리 별로 분리 해서 데이터 저장
        if (weather.category == "TMP") {
          // 기온
          weatherInstances['TMP'] = "${weather.fcstValue}℃";
        } else if (weather.category == "WSD") {
          // 풍속
          weatherInstances['WSD'] = "${weather.fcstValue}m/s";
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
        } else if (weather.category == "POP") {
          // 강수확률
          weatherInstances['POP'] = "${weather.fcstValue}%";
        } else if (weather.category == "PCP") {
          // 1시간 강수량
          weatherInstances['PCP'] = weather.fcstValue;
        } else if (weather.category == "REH") {
          // 습도
          weatherInstances['REH'] = "${weather.fcstValue}%";
        } else if (weather.category == "SNO") {
          // 1시간 신적설
          weatherInstances['SNO'] = weather.fcstValue;
        } else if (weather.category == "WSD") {
          // 풍속
          weatherInstances['WSD'] = "${weather.fcstValue}m/s";
        } else if (weather.category == "TMN") {
          // 최저기온
          weatherInstances['TMN'] = "${weather.fcstValue}℃";
        } else if (weather.category == "TMX") {
          // 최고기온
          weatherInstances['TMX'] = "${weather.fcstValue}℃";
        }
      }

      return weatherInstancesList;
    }

    throw Error();
  }
}
