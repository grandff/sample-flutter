import 'package:intl/intl.dart';

class DateUtility {
  // 오늘 날짜 리턴
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("yyyyMMdd");
    var today = formatter.format(now);
    return today;
  }

  // 현재 시간 기준으로 단기예보 기준 시간 변경
  String getTimeForFcst() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("H");

    // 이거 한국시간으로 어케나옴? 로컬데이터로 하는게 먼가 있어야할듯 ㅅㅂ

    var todayHour = formatter.format(now);
    return todayHour;
  }
}
