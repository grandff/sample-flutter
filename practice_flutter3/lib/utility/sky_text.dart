class SkyUtility {
  final String sky, pty;

  SkyUtility({required this.sky, required this.pty});

  static Future<String> changeToImgFileName(sky, pty) async {
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

  static Future<String> changeSkyStr(sky, pty) async {
    late String result = "맑음";
    if (pty == "1") {
      result = "비";
    } else if (pty == "2") {
      result = "비/눈";
    } else if (pty == "3") {
      result = "눈";
    } else if (pty == "4") {
      result = "소나기";
    } else {
      if (sky == "1") {
        result = "맑음";
      } else if (sky == "3") {
        result = "구름많음";
      } else if (sky == "4") {
        result = "흐림";
      }
    }

    return result;
  }
}
