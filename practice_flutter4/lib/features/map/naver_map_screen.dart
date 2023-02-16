import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_flutter4/services/geolocator_service.dart';
import 'package:practice_flutter4/services/map_marker_temp_service.dart';

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
  List<Map<String, dynamic>> _markerList = []; // 마커 위치정보

  // 마커정보 호출
  Future<void> _loadMakerValues() async {
    var markers = await MapMarkerTempService.markerTest();
    setState(() {
      _markerList = markers;
    });
  }

  // bottom sheet call
  Future<dynamic> _showInfoSheet(String title) {
    return showModalBottomSheet(
      context: context,
      // material design 3를 적용한 경우 테두리를 동그랗게 주려면 shape 속성을 사용해야함
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                      )),
                ],
              ),
              const Text("여기는 주소가 들어갈겁니다."),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: const Text(
                      "길찾기",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    nowLocation = GeolocatorService.determinePosition(); // 현재 위치
    //_loadMakerValues(); // marker 정보 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _naverMapSection(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /* 현재 지도에서의 위치를 불러옴 */
          final test2 = await _naverMapController
              .getCameraPosition()
              .then((value) => value.target);
          print("now position : $test2");
        },
      ),
    );
  }

  Widget _naverMapSection() => NaverMap(
        options: const NaverMapViewOptions(
          // 맵옵션
          indoorEnable: true,
          locationButtonEnable: true,
          consumeSymbolTapEvents: false,
          zoomGesturesEnable: true,
        ),
        onMapReady: (controller) async {
          await _loadMakerValues(); // 마커 정보 호출

          _naverMapController = controller;
          mapControllerComplete.complete(controller);

          /* 길찾기 그리기 */
          var marker1 = const NLatLng(37.5588195386098, 126.98048476629486);
          var marker2 = const NLatLng(37.57457431756785, 126.98567636783872);
          var marker3 = const NLatLng(37.559141132983484, 126.97516829469322);
          var positionList = [
            marker1,
            marker2,
            marker3,
          ]; // 마커리스트
          // 길찾기
          final nArrowHeadPath = NArrowheadPathOverlay(
            id: "9",
            coords: positionList,
            color: Colors.pink,
            width: 10,
            outlineWidth: 5,
            outlineColor: Colors.amber,
          );
          _naverMapController.addOverlay(nArrowHeadPath);
          /* // 길찾기 그리기 */

          /* 지정 위치에 마커 찍기 */
          _loadMakerValues();
          print("length : ${_markerList.length}");
          if (_markerList.isNotEmpty) {
            for (var entry in _markerList.asMap().entries) {
              // key-value 형태의 entry로 리턴
              var index = entry.key; // index
              var map = entry.value; // map
              final marker = NMarker(
                id: index.toString(),
                position: NLatLng(map['lat']!, map['lng']!),
              );
              _naverMapController.addOverlay(marker); // 마커 찍기

              // info window 추가
              final infoWindow = NInfoWindow.onMarker(
                id: index.toString(),
                text: map['title'].toString(),
              );

              infoWindow.setOnTapListener((overlay) {
                // material bottom design add
                _showInfoSheet(map['title']);
              });

              await marker.openInfoWindow(infoWindow);
            }
          }
          /* // 지정 위치에 마커 찍기 */
        },
        onMapTapped: (point, latLng) async {
          print("test : ${_naverMapController.getCameraPosition().toString()}");

          /* 지도 찍은 위치에 마커 생성 */
          final marker = NMarker(
            id: latLng.toString(),
            position: latLng,
          ); // 선택한 지점 마커 객체 생성
          print("latlng : $latLng");
          _naverMapController.addOverlay(marker); // 마커 찍기

          /* 마커 위에 window */
          final infoWindow =
              NInfoWindow.onMarker(id: "$point$latLng", text: "$point");
          infoWindow.setOnTapListener((overlay) {
            overlay.close();
            // material bottom design add
            _showInfoSheet("${latLng.latitude}&${latLng.longitude}");
          });
          await marker.openInfoWindow(infoWindow);
        },
      );
}
