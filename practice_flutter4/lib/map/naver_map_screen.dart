import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_flutter4/services/geolocator_service.dart';

class NaverMapScreen extends StatefulWidget {
  const NaverMapScreen({
    super.key,
  });

  @override
  State<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  late NaverMapController _naverMapController; // 네이버맵 컨트롤러
  final Completer<NaverMapController> mapControllerComplete = Completer();
  late Future<Position> nowLocation; // 현재 위치 정보 불러오기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _naverMapSection(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    nowLocation = GeolocatorService.determinePosition(); // 현재 위치
  }

  Widget _naverMapSection() => NaverMap(
        options: const NaverMapViewOptions(
          // 맵옵션
          indoorEnable: true,
          locationButtonEnable: true,
          consumeSymbolTapEvents: false,
        ),
        onMapReady: (controller) async {
          _naverMapController = controller;
          mapControllerComplete.complete(controller);
          print("map ready!");
        },
        onMapTapped: (point, latLng) async {
          /* 지도 찍은 위치에 마커 생성 */
          final marker = NMarker(
            id: latLng.toString(),
            position: latLng,
          ); // 선택한 지점 마커 객체 생성
          _naverMapController.addOverlay(marker); // 마커 찍기

          /* 마커 위에 window */
          final infoWindow =
              NInfoWindow.onMarker(id: "$point$latLng", text: "$point");
          infoWindow.setOnTapListener((overlay) => overlay.close());
          await marker.openInfoWindow(infoWindow);
        },
      );
}
