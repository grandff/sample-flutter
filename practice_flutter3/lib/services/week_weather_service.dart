import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_flutter3/models/weather/mid_fcst_model.dart';
import 'package:practice_flutter3/models/weather/mid_ta_model.dart';
import 'package:practice_flutter3/utility/get_today.dart';

class WeekWeatherService {
  final String regArea, regId;
  WeekWeatherService({
    required this.regArea,
    required this.regId,
  });

  // apikey
  static const String apiKey =
      "yXugn7gIb5dEF5jMX1UjuV4qiy%2Bczf9hX3GZhu%2Fp3kxVI9JbMCvBGPHpKVp5QkAOllYDPlfSnSw0CDX7ZGGYsg%3D%3D";
  // 기상정보
  static const String fcstUrl =
      "http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst";
  // 기온정보
  static const String taUrl =
      "http://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa";

  // 3일 후부터 7일 후 까지 정보종합
  static Future<Map<String, dynamic>> getNextWeekWeathers(
      regArea, regId) async {
    Map<String, dynamic> weekWeatherInstances = {};
    // 날짜는 오늘날짜
    var today = DateUtility().getToday();
    // 현재 시간이 오전 또는 오후인지에 따라 기준 시간 분기처리 (0600, 1800)
    var fcstTime = DateUtility().getMidFcstTime();
    try {
      weekWeatherInstances['weather'] =
          await getMidLandFcst(regArea, today, fcstTime);
      weekWeatherInstances['temp'] = await getMidTa(regId, today, fcstTime);
      return weekWeatherInstances;
    } catch (e) {
      throw Error();
    }
  }

  // 3일 후부터 7일 후 까지 기상정보
  static Future<Map<String, dynamic>> getMidLandFcst(
      regArea, today, fcstTime) async {
    Map<String, dynamic> fcstInstances = {};

    // 중기 기상정보 call
    final url = Uri.parse(
        '$fcstUrl?serviceKey=$apiKey&numOfRows=10&pageNo=1&regId=$regArea&tmFc=$today$fcstTime&dataType=JSON');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = MidFcstModel.fromJson(fullData);
      final MidFcstItemsModel weatherList = parsingData.response.body.items;
      for (var weather in weatherList.item) {
        fcstInstances['regId'] = weather.regId;
        fcstInstances['wf3Am'] = weather.wf3Am;
        fcstInstances['wf3Pm'] = weather.wf3Pm;
        fcstInstances['wf4Am'] = weather.wf4Am;
        fcstInstances['wf4Pm'] = weather.wf4Pm;
        fcstInstances['wf5Am'] = weather.wf5Am;
        fcstInstances['wf5Pm'] = weather.wf5Pm;
        fcstInstances['wf6Am'] = weather.wf6Am;
        fcstInstances['wf6Pm'] = weather.wf6Pm;
        fcstInstances['wf7Am'] = weather.wf7Am;
        fcstInstances['wf7Pm'] = weather.wf7Pm;
        fcstInstances['rnSt3Am'] = weather.rnSt3Am;
        fcstInstances['rnSt3Pm'] = weather.rnSt3Pm;
        fcstInstances['rnSt4Am'] = weather.rnSt4Am;
        fcstInstances['rnSt4Pm'] = weather.rnSt4Pm;
        fcstInstances['rnSt5Am'] = weather.rnSt5Am;
        fcstInstances['rnSt5Pm'] = weather.rnSt5Pm;
        fcstInstances['rnSt6Am'] = weather.rnSt6Am;
        fcstInstances['rnSt6Pm'] = weather.rnSt6Pm;
        fcstInstances['rnSt7Am'] = weather.rnSt7Am;
        fcstInstances['rnSt7Pm'] = weather.rnSt7Pm;
      }

      return fcstInstances;
    }

    throw Error();
  }

  // 3일 후부터 7일 후 까지 기온정보
  static Future<Map<String, dynamic>> getMidTa(regId, today, fcstTime) async {
    Map<String, dynamic> taInstances = {};

    // 중기 기온정보 call
    final url = Uri.parse(
        '$taUrl?serviceKey=$apiKey&numOfRows=10&pageNo=1&regId=$regId&tmFc=$today$fcstTime&dataType=JSON');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = MidTaModel.fromJson(fullData);
      final MidTaItemsModel taList = parsingData.response.body.items;
      for (var ta in taList.item) {
        taInstances['regId'] = ta.regId;
        taInstances['taMin3'] = ta.taMin3;
        taInstances['taMax3'] = ta.taMax3;
        taInstances['taMin4'] = ta.taMin4;
        taInstances['taMax4'] = ta.taMax4;
        taInstances['taMin5'] = ta.taMin5;
        taInstances['taMax5'] = ta.taMax5;
        taInstances['taMin6'] = ta.taMin6;
        taInstances['taMax6'] = ta.taMax6;
        taInstances['taMin7'] = ta.taMin7;
        taInstances['taMax7'] = ta.taMax7;
      }

      return taInstances;
    }

    throw Error();
  }
}
