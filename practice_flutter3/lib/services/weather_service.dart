import 'dart:convert';

import 'package:practice_flutter3/models/getVilageFcst/fcst_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter3/utility/get_today.dart';

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

    // 전체 시/도별로 날씨를 가져온다
    // 날짜는 오늘날짜
    // 시간은 단기예보에 맞게 설정하기
    var today = DateUtility().getToday();
    var todayHour = DateUtility().getTimeForFcst();
    print("gogo : $today, $todayHour");

    // enum 요소 길이 만큼 루프 가능? 그게 아니면 그냥 직접 지정해서 돌리기

    // 날씨 api call
    final url = Uri.parse(
        '$baseUrl?serviceKey=$apiKey&numOfRows=50&pageNo=1&dataType=JSON&base_date=20230112&base_time=0500&nx=60&ny=127');
    print(url);
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = FcstModel.fromJson(fullData);
      final FcstItemsModel weatherList = parsingData.response.body.items;
      for (var weather in weatherList.item) {
        // baseDate":"20230112","baseTime":"0500","category":"UUU","fcstDate":"20230112","fcstTime":"0600","fcstValue":"-1.2","nx":60,"ny":127

        var temp = <String, dynamic>{};
        print(weather.baseDate);
      }
    }

    return "hi";
    //throw Error();
  }
}
