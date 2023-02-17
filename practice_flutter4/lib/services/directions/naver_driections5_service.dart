import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter4/features/navigation/models/directions5_model.dart';

class NaverDirections5Service {
  final double startLatitude, startLongitude, goalLatitude, goalLongitude;

  NaverDirections5Service({
    required this.startLatitude,
    required this.startLongitude,
    required this.goalLatitude,
    required this.goalLongitude,
  });

  // 네이버 direction5 url
  static const String direction5Url =
      "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving";

  // 네이버 client key
  static var naverMapClientKey = dotenv.env['NAVER_MAP_CLIENT_ID'];

  // 네이버 secret key
  static var naverMapSecretKey = dotenv.env['NAVER_MAP_SECRET_ID'];

  // 네이버 directions5 call Future<NavigationResponse>
  static Future<NavigationResponse> naverDirections5Api(
      startLatitude, startLongitude, goalLatitude, goalLongitude) async {
    final url = Uri.parse(
        '$direction5Url?start=$startLongitude,$startLatitude&goal=$goalLongitude,$goalLatitude&option=trafast');
    final headers = {
      'X-NCP-APIGW-API-KEY-ID': naverMapClientKey!,
      'X-NCP-APIGW-API-KEY': naverMapSecretKey!,
    };
    final response = await http.get(url, headers: headers);

    // 응답 파싱처리
    if (response.statusCode == 200) {
      final jsonData =
          json.decode(utf8.decode(response.bodyBytes)); // 한글꺠짐 현상 해결

      final parsingData = NavigationResponse.fromJson(jsonData);
      return parsingData;
    }

    throw Error();
  }
}
