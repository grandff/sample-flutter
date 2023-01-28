import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_flutter3/models/weather/wrn_model.dart';

class WrnInfoService {
  // apikey
  static const String apiKey =
      "yXugn7gIb5dEF5jMX1UjuV4qiy%2Bczf9hX3GZhu%2Fp3kxVI9JbMCvBGPHpKVp5QkAOllYDPlfSnSw0CDX7ZGGYsg%3D%3D";
  // 특보 현황 조회
  static const String wrnUrl =
      "http://apis.data.go.kr/1360000/WthrWrnInfoService/getPwnStatus";

  // 오늘날짜 기준 특보 현황 조회
  static Future<Map<String, dynamic>> getPwnStatus() async {
    Map<String, dynamic> wrnInstances = {};
    // url call
    final url = Uri.parse(
        '$wrnUrl?serviceKey=$apiKey&numOfRows=1000&pageNo=1&dataType=JSON');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = WrnModel.fromJson(fullData);
      final WrnItemsModel wrnList = parsingData.response.body.items;
      for (var wrn in wrnList.item) {
        wrnInstances['other'] = wrn.other.toString().split("\n"); // 참고사항
        var t6List = wrn.t6.toString().split("\n"); // 특보발효현황 내용
        wrnInstances['t6Length'] = t6List.length;
        wrnInstances['t6'] = t6List;
        wrnInstances['t7'] = wrn.t7.toString().split("\n"); // 예비특보 발효현황
        wrnInstances['tmEf'] = wrn.tmEf; // 특보발효현황 시각
        wrnInstances['tmFc'] = wrn.tmFc; // 발표시각
        wrnInstances['tmSeq'] = wrn.tmSeq;
      }

      return wrnInstances;
    }

    throw Error();
  }
}
