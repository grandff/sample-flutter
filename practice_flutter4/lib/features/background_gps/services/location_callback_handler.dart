import 'package:background_locator_2/location_dto.dart';
import 'package:practice_flutter4/features/background_gps/services/location_service_repository.dart';

class LocationCallbackHandler {
  // 콜백 초기화
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.init(params);
  }

  // 콜백 삭제
  static Future<void> disposeCallback() async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.dispose();
  }

  // 콜백
  static Future<void> callback(LocationDto locationDto) async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.callback(locationDto);
  }

  // notification
  static Future<void> notificationCallback() async {
    print("***notification callback");
  }
}
