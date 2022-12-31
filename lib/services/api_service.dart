import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_flutter/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    // async를 쓰기 때문에 future를 붙여야함
    List<WebtoonModel> webtoonInstances = [];
    // await 를 쓰기위해 async 선언
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body); // 응답형식을 json으로 디코딩
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }

    throw Error(); // 정상이 아닌 경우 오류 처리
  }
}
