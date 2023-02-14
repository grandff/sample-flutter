import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapScreen extends StatelessWidget {
  const NaverMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NaverMap(
        options: const NaverMapViewOptions(),
        onMapReady: (controller) {},
        onMapTapped: (point, latLng) {},
        onSymbolTapped: (symbol) {},
        onCameraChange: (reason, animated) {},
        onCameraIdle: () {},
        onSelectedIndoorChanged: (selectedIndoor) {},
      ),
    );
  }
}
