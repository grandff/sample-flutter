import 'dart:convert';

import 'package:practice_flutter3/models/getVilageFcst/fcst_model.dart';
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
  static Future<String> getTodayWeathers() async {
    List<FcstItemModel> weatherInstances = [];

    // 날씨 api call
    final url = Uri.parse(
        '$baseUrl?serviceKey=$apiKey&numOfRows=50&pageNo=1&dataType=JSON&base_date=20230111&base_time=0500&nx=60&ny=127');
    print(url);
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = FcstModel.fromJson(fullData);

      FcstItemsModel test = parsingData.response.body.items;
      print(test.item.length);
      for (var weather in test.item) {
        print(weather.baseDate);
      }

      //final List<FcstItemsModel> weathersList =
      //  parsingData.response.body.items as List<FcstItemsModel>;

      //for (var weather in weathersList) {
      // print(weather);
      //weatherInstances.add(instance);
      //}

      //for (var weather in weathers) {
      //final instance = WeatherModel.fromJson(weather);
//        print(weather);
      //      weatherInstances.add(instance);
      //print(instance);
      //  }
    }
    //return "hi";

    return "hi";
    //throw Error();
  }
}
