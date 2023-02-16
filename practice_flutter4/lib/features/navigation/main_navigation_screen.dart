import 'package:flutter/material.dart';
import 'package:practice_flutter4/features/map/naver_map_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0; // 선택 인덱스
  final screens = [
    const NaverMapScreen(),
    const Center(
      child: Text('coord'),
    ),
  ];

  // ontap
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "지도",
          ),
          NavigationDestination(
            icon: Icon(Icons.location_searching),
            label: "좌표",
          ),
        ],
      ),
    );
  }
}
