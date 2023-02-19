import 'package:background_locator_2/location_dto.dart';

class LocationServiceRepository {
  static final LocationServiceRepository _instance =
      LocationServiceRepository._();
  LocationServiceRepository._();

  // instacne 생성 ? 싱글톤 패턴으로 구현
  factory LocationServiceRepository() {
    return _instance;
  }

  Future<void> init(Map<dynamic, dynamic> params) async {
    print("gps tracking... init call back handler");
  }

  Future<void> dispose() async {
    print("gps tracking... dispose callback handler");
  }

  // call back function.. 위치를 기록하는거 같음?
  Future<void> callback(LocationDto locationDto) async {
    print('gps tracking... location in dart : ${locationDto.toString()}');
    await setLogPosition(locationDto);
  }

  // 좌표기록 저장
  static Future<void> setLogPosition(LocationDto data) async {
    final date = DateTime.now();
    print("gps tracking... ${data.toString()}");
  }
}
