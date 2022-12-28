import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  void getTodaysToons() async {
    // await 를 쓰기위해 async 선언
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      return;
    }

    throw Error(); // 정상이 아닌 경우 오류 처리
  }
}
