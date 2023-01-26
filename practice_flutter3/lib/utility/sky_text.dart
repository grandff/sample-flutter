class SkyUtility {
  final String sky, pty;

  SkyUtility({required this.sky, required this.pty});

  static Future<String> changeToImgFileName(sky, pty) async {
    print("img file create on!");
    late String result;
    if (pty == "1" || pty == "2" || pty == "4" || pty == "5" || pty == "6") {
      result = "rainy";
    } else if (pty == "3" || pty == "7") {
      result = "snowy";
    } else {
      // 0인 경우 sky에 해당하는 상태 리턴
      if (sky == "1") {
        result = "sun";
      } else if (sky == "3") {
        result = "cloudy";
      } else if (sky == "4") {
        result = "verycloudy";
      } else {
        result = "sun";
      }
    }
    return result;
  }
}
