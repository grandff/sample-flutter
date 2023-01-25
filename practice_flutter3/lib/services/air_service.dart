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
  static Future<Map<String, dynamic>> getAirMesure(
      sidoNm, region3depthName) async {
    Map<String, dynamic> airInstances = {};

    // 대기조회 API Call
    final url = Uri.parse(
        '$baseUrl?serviceKey=$apiKey&returnType=json&numOfRows=1000&ver=1.0&sidoName=$sidoNm');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final fullData = jsonDecode(response.body);
      final parsingData = AirFullModel.fromJson(fullData);
      final List<AirModel> airList = parsingData.response.body.items;
      final String stationCheck = region3depthName
          .toString()
          .substring(0, region3depthName.toString().length - 1);

      for (AirModel air in airList) {
        if (air.dataTime == "") continue; // 측정시간이 없으면 패스
        // 현재 시군구에 해당하는 데이터가 있는지 확인
        // 사용자가 위치한 행정동과 비슷한 측정장소가 있으면 우선적으로 가져옴
        if (air.stationName.contains(stationCheck)) {
          airInstances['stationName'] = air.stationName;
          airInstances['dataTime'] = air.dataTime;
          airInstances['pm10Value'] = air.pm10Value;
          airInstances['pm10Flag'] = air.pm10Flag;
          airInstances['pm25Value'] = air.pm25Value;
          airInstances['pm25Flag'] = air.pm25Flag;
        }
      }

      // 만약 없을 경우 .. 통신장애 아닌 것들 중에서 최신 데이터 하나 가져오기
      if (airInstances.isEmpty) {
        for (AirModel air in airList) {
          if (air.dataTime == "") continue; // 측정시간이 없으면 패스
          airInstances['stationName'] = air.stationName;
          airInstances['dataTime'] = air.dataTime;
          airInstances['pm10Value'] = air.pm10Value;
          airInstances['pm10Flag'] = air.pm10Flag;
          airInstances['pm25Value'] = air.pm25Value;
          airInstances['pm25Flag'] = air.pm25Flag;
          break;
        }
      }

      return airInstances;
    }
    throw Error();
  }
}
