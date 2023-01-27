import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateUtility {
  // 오늘 날짜 리턴
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("yyyyMMdd");
    var today = formatter.format(now);
    return today;
  }

  // 내일 날짜 리턴
  String getNextDay() {
    DateTime now = DateTime.now();
    DateTime nextDay = now.add(const Duration(days: 1));
    DateFormat formatter = DateFormat("yyyyMMdd");
    var next = formatter.format(nextDay);
    return next;
  }

  // 원하는 일자 리턴
  String getDurationDay(int addDays) {
    DateTime now = DateTime.now();
    DateTime durationDay = now.add(Duration(days: addDays));
    DateFormat formatter = DateFormat("yyyyMMdd");
    var next = formatter.format(durationDay);
    return next;
  }

  // 해당 날짜의 요일 리턴
  String getWeekdayFromString(String date) {
    date =
        "${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}";
    DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
    return DateFormat('EEEE', 'ko_KO').format(parsedDate);
  }

  // 모레 날짜 리턴
  String getDayAfter() {
    DateTime now = DateTime.now();
    DateTime nextDay = now.add(const Duration(days: 2));
    DateFormat formatter = DateFormat("yyyyMMdd");
    var next = formatter.format(nextDay);
    return next;
  }

  // 오늘 요일 리턴
  String getDayOfWeek() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("EEEE");
    var ee = formatter.format(now);
    if (ee == "Monday") {
      ee = "월";
    } else if (ee == "Tuesday") {
      ee = "화";
    } else if (ee == "Wednesday") {
      ee = "수";
    } else if (ee == "Thursday") {
      ee = "목";
    } else if (ee == "Friday") {
      ee = "금";
    } else if (ee == "Saturday") {
      ee = "토";
    } else if (ee == "Sunday") {
      ee = "일";
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
    DateTime koreanNow = now.add(const Duration(hours: 9));
    DateFormat formatter = DateFormat("HH");

    // 이거 한국시간으로 어케나옴? 로컬데이터로 하는게 먼가 있어야할듯 ㅅㅂ
    // 일단 미국시간 기준으로 해놓기
    var todayHour = formatter.format(koreanNow).toString();

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

  // 현재 시간 가져옴
  String getNowTime() {
    initializeDateFormatting('ko', null); // ?? 이렇게 해도 한국시간으로 설정이 안됨..?
    DateTime now = DateTime.now();
    DateTime koreanNow = now.add(const Duration(hours: 9));
    DateFormat dateFormat = DateFormat('aa hh:mm', 'ko');
    var nowTime = dateFormat.format(koreanNow);
    return nowTime;
  }

  // 현재 시간 기준으로 단기예보 기준 시간 변경
  String getTimeForNow() {
    DateTime now = DateTime.now();
    DateTime koreanNow = now.add(const Duration(hours: 9));
    DateFormat formatter = DateFormat("HH");
    var nowTime = formatter.format(koreanNow);
    return "${nowTime}00";
    // 이거 한국시간으로 어케나옴? 로컬데이터로 하는게 먼가 있어야할듯 ㅅㅂ
    // 일단 미국시간 기준으로 해놓기
  }

  // 현재 시간 가져옴
  String getTimeForTodayWeather() {
    DateTime now = DateTime.now();
    DateTime koreanNow = now.add(const Duration(hours: 9));
    DateFormat dateFormat = DateFormat('Hm');
    var nowTime = dateFormat.format(koreanNow).replaceAll(":", "");
    var timeCheck = int.parse(nowTime);
    late String timeResult;

    if (timeCheck < 2330 && timeCheck >= 2230) {
      timeResult = "2230";
    } else if (timeCheck < 30 && timeCheck >= 2330) {
      timeResult = "2330";
    } else if (timeCheck < 130 && timeCheck >= 30) {
      timeResult = "0030";
    } else if (timeCheck < 230 && timeCheck >= 130) {
      timeResult = "0130";
    } else if (timeCheck < 330 && timeCheck >= 230) {
      timeResult = "0230";
    } else if (timeCheck < 430 && timeCheck >= 330) {
      timeResult = "0330";
    } else if (timeCheck < 530 && timeCheck >= 430) {
      timeResult = "0430";
    } else if (timeCheck < 630 && timeCheck >= 530) {
      timeResult = "0530";
    } else if (timeCheck < 730 && timeCheck >= 630) {
      timeResult = "0630";
    } else if (timeCheck < 830 && timeCheck >= 730) {
      timeResult = "0730";
    } else if (timeCheck < 930 && timeCheck >= 830) {
      timeResult = "0830";
    } else if (timeCheck < 1030 && timeCheck >= 930) {
      timeResult = "0930";
    } else if (timeCheck < 1130 && timeCheck >= 1030) {
      timeResult = "1030";
    } else if (timeCheck < 1230 && timeCheck >= 1130) {
      timeResult = "1130";
    } else if (timeCheck < 1330 && timeCheck >= 1230) {
      timeResult = "1230";
    } else if (timeCheck < 1430 && timeCheck >= 1330) {
      timeResult = "1330";
    } else if (timeCheck < 1530 && timeCheck >= 1430) {
      timeResult = "1430";
    } else if (timeCheck < 1630 && timeCheck >= 1530) {
      timeResult = "1530";
    } else if (timeCheck < 1730 && timeCheck >= 1630) {
      timeResult = "1630";
    } else if (timeCheck < 1830 && timeCheck >= 1730) {
      timeResult = "17030";
    } else if (timeCheck < 1930 && timeCheck >= 1830) {
      timeResult = "1830";
    } else if (timeCheck < 2030 && timeCheck >= 1930) {
      timeResult = "1930";
    } else if (timeCheck < 2130 && timeCheck >= 2030) {
      timeResult = "2030";
    } else if (timeCheck < 2230 && timeCheck >= 2130) {
      timeResult = "2130";
    } else {
      timeResult = "0030";
    }

    return timeResult;
  }

  // 시간영역체크
  bool checkNowTimeFlag(String timeListVal) {
    DateTime now = DateTime.now();
    DateTime koreanNow = now.add(const Duration(hours: 9));
    DateFormat dateFormat = DateFormat('HH');
    var nowTime = dateFormat.format(koreanNow);
    return (timeListVal == nowTime);
  }
}
