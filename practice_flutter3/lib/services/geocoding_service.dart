import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeocodingService {
  final latitude;
  final longitude;

  GeocodingService({required this.latitude, required this.longitude});

  // kakao rest api key
  static var kakaoKey = dotenv.env['KAKAO_KEY'];

  // kakao api url
  static var kakaoBaseUrl = dotenv.env['KAKAO_GEO_URL'];
  //"https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=127.1086228&y=37.4012191"

  /*
  curl -v -X GET "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=127.1086228&y=37.4012191" \
  -H "Authorization: KakaoAK ${REST_API_KEY}"
  */

  static Future<String> coord2region(latitude, longitude) async {
    print("latitude : $latitude, longitude : $longitude");
    final url = Uri.parse('$kakaoBaseUrl?x=$latitude&y=$longitude');
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "KakaoAK $kakaoKey"});
    print(response.body);
    return "hi";
  }
}
