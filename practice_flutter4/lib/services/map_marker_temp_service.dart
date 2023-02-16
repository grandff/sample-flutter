class MapMarkerTempService {
  static Future<List<Map<String, dynamic>>> markerTest() async {
    await Future.delayed(const Duration(seconds: 1)); // 비동기테스트용

    var marker1 = {
      'lat': 37.55120897210992,
      'lng': 126.97193681401313,
      'title': "장소1",
    };
    var marker2 = {
      'lat': 37.54853872357276,
      'lng': 126.97812634727228,
      'title': "장소2",
    };
    var marker3 = {
      'lat': 37.54627689394253,
      'lng': 126.97200619326696,
      'title': "장소3",
    };

    var resultList = <Map<String, dynamic>>[];
    resultList.add(marker1);
    resultList.add(marker2);
    resultList.add(marker3);

    return resultList;
  }
}
