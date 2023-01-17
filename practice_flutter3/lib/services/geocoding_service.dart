import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter3/models/location/geocoding_model.dart';

class GeocodingService {
  final latitude;
  final longitude;

  GeocodingService({required this.latitude, required this.longitude});

  // kakao rest api key
  static var kakaoKey = dotenv.env['KAKAO_KEY'];
  // kakao api url
  static var kakaoBaseUrl = dotenv.env['KAKAO_GEO_URL'];

  static Future<RegionCodeModel> coord2region(latitude, longitude) async {
    final url = Uri.parse('$kakaoBaseUrl?x=$longitude&y=$latitude');
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "KakaoAK $kakaoKey"});
    late RegionCodeModel resultData;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final parsingData = RegionFullModel.fromJson(jsonData);

      for (var region in parsingData.documents) {
        // 법정동일 경우에만 데이터 추출
        if (region.regionType == "B") {
          resultData = region;
        }
      }

      return resultData;
    }

    throw Error();
  }
}
