import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SkyWidget extends StatelessWidget {
  final String sky, pty;

  const SkyWidget({
    super.key,
    required this.sky,
    required this.pty,
  });

  // 하늘상태 확인
  String checkSkyState(sky, pty) {
    // pty과 0이 아닐 경우 우선 지정
    if (pty == "1" || pty == "2" || pty == "4" || pty == "5" || pty == "6") {
      return "rainy";
    } else if (pty == "3" || pty == "7") {
      return "snowy";
    } else {
      // 0인 경우 sky에 해당하는 상태 리턴
      if (sky == "1") {
        return "sun";
      } else if (sky == "3") {
        return "cloudy";
      } else if (sky == "4") {
        return "verycloudy";
      } else {
        return "sun";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
