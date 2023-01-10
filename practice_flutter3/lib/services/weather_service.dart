import 'dart:convert';

import 'package:practice_flutter3/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // 날씨 요청 API (단기예보조회)
  static const String baseUrl =
      "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";

  // serviceKey=인증키&numOfRows=10&pageNo=1

  // 날씨 요청 API Key
  static const String apiKey =
      "yXugn7gIb5dEF5jMX1UjuV4qiy%2Bczf9hX3GZhu%2Fp3kxVI9JbMCvBGPHpKVp5QkAOllYDPlfSnSw0CDX7ZGGYsg%3D%3D";

  // 오늘 전체 날씨 목록 (지역별로..)
  static Future<List<String>> getTodayWeathers() async {
    List<String> weatherInstances = [];

    // 날씨 api call
    final url = Uri.parse(
        '$baseUrl?serviceKey=$apiKey&numOfRows=50&pageNo=1&dataType=JSON&base_date=20230110&base_time=0500&nx=60&ny=127');
    print(url);
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final weathers = jsonDecode(response.body);      
      
      final responseBody = weathers.fromJson(Map<String, dynamic> json) : response = json['response'];
      for (var weather in weathers) {
        //final instance = WeatherModel.fromJson(weather);
        //weatherInstances.add(instance);
        //print(instance);
      }
    }

    throw Error();
  }
}
