import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  // 현재 내 위치정보 가져오기
  static Future<Position> determinePosition() async {
    bool serviceEnabled; // 서비스 가능여부
    LocationPermission permission; // 위치정보 사용 권한

    // 서비스가 가능한지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 사용이 불가능한 경우 오류 리턴
      return Future.error("위치 서비스 사용 불가");
    }

    // 권한확인
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 권한이 거부된경우 다시 한번 요청
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("위치 서비스 권한 거부");
      }
    }

    // 위치 서비스를 아예 허용 안할 경우
    if (permission == LocationPermission.deniedForever) {
      return Future.error("평생 사용 못함");
    }

    // 현재 위치정보 리턴
    return await Geolocator.getCurrentPosition();
  }
}
