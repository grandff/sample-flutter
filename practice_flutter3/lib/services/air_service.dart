import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_flutter3/models/air/air_model.dart';

class AirService {
  final String sidoNm;
  final String region3depthName;

  AirService({
    required this.sidoNm,
    required this.region3depthName,
  });

  // 실시간대기조회 API URL
  static const String baseUrl =
      "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";

  // 실시간대기조회 API Key
  static const String apiKey =
      "yXugn7gIb5dEF5jMX1UjuV4qiy%2Bczf9hX3GZhu%2Fp3kxVI9JbMCvBGPHpKVp5QkAOllYDPlfSnSw0CDX7ZGGYsg%3D%3D";

  // 실시간대기정보 조회
  static Future<String> getAirMesure(sidoNm, region3depthName) async {
    Map<String, dynamic> airInstances = {};

    // 대기조회 API Call
    // 전국, 서울, 부산, 대구, 인천, 광주, 대전, 울산, 경기, 강원, 충북, 충남, 전북, 전남, 경북, 경남, 제주, 세종
    final url = Uri.parse(
        '$baseUrl?serviceKey=$apiKey&returnType=json&numOfRows=1000&ver=1.0&sidoName=$sidoNm');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = AirFullModel.fromJson(fullData);
      final List<AirModel> airList = parsingData.response.body.items;

      for (AirModel air in airList) {
        print(air.stationName);
        print(air.dataTime);
      }
      // 현재 시군구에 해당하는 데이터가 있는지 확인
      // 만약 없을 경우 .. 통신장애 아닌 것들 중에서 최신 데이터 하나 가져오기
    }
    return "";
  }
}
