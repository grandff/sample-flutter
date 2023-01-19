import 'package:intl/intl.dart';

class DateUtility {
  // 오늘 날짜 리턴
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("yyyyMMdd");
    var today = formatter.format(now);
    return today;
  }

  // 오늘 요일 리턴
  String getDayOfWeek() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("EEEE");
    var ee = formatter.format(now);
    if (ee == "Monday") {
      ee = "월요일";
    } else if (ee == "Tuesday") {
      ee = "화요일";
    } else if (ee == "Wednesday") {
      ee = "수요일";
    } else if (ee == "Thursday") {
      ee = "목요일";
    } else if (ee == "Friday") {
      ee = "금요일";
    } else if (ee == "Saturday") {
      ee = "토요일";
    } else if (ee == "Sunday") {
      ee = "일요일";
    }

    return ee;
  }

  // 오늘 날짜 풀
  String getFullToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("yyyy.MM.dd");
    var today = formatter.format(now);
    return today;
  }

  // 현재 시간 기준으로 단기예보 기준 시간 변경
  String getTimeForFcst() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("H");

    // 이거 한국시간으로 어케나옴? 로컬데이터로 하는게 먼가 있어야할듯 ㅅㅂ
    // 일단 미국시간 기준으로 해놓기
    var todayHour = formatter.format(now);
    todayHour = (int.parse(todayHour) + 9).toString();

    //Base_time : 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300 (1일 8회)
    var checkHour = int.parse(todayHour);
    if (checkHour >= 2 && checkHour < 5) {
      todayHour = "0200";
    } else if (checkHour >= 5 && checkHour < 8) {
      todayHour = "0500";
    } else if (checkHour >= 8 && checkHour < 11) {
      todayHour = "0800";
    } else if (checkHour >= 11 && checkHour < 14) {
      todayHour = "1100";
    } else if (checkHour >= 14 && checkHour < 17) {
      todayHour = "1400";
    } else if (checkHour >= 17 && checkHour < 20) {
      todayHour = "1700";
    } else if (checkHour >= 20 && checkHour < 23) {
      todayHour = "2000";
    } else if (checkHour >= 23 && checkHour < 24) {
      todayHour = "2300";
    } else {
      todayHour = "0200";
    }

    return todayHour;
  }
}
