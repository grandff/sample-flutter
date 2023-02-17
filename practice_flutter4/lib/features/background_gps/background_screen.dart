import 'dart:async';
import 'dart:isolate';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:flutter/material.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  ReceivePort port = ReceivePort();
  String logStr = '';
  bool isRunning = false;
  late LocationDto lastLocation; // ??

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // background locator 활성화
  Future<void> initPlatformState() async {
    print("init..");
    await BackgroundLocator.initialize();
    final serviceRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = serviceRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('hi')],
      ),
    );
  }
}
