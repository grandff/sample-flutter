import 'dart:async';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart'
    as background_locator_2;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter4/features/background_gps/services/location_callback_handler.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    initPlatformState(); // background locator 활성화
    if (isRunning) {
      // background locator가 실행중일 때 서비스 시작
      _startLocator();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // background locator 활성화
  Future<void> initPlatformState() async {
    print("gps tracking ... platform init..");
    await BackgroundLocator.initialize();
    final serviceRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = serviceRunning;
    });
  }

  // backgground locator 시작
  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1}; // custom한 버전은 굳이 필요없을듯?
    return await BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      initDataCallback: data,
      disposeCallback: LocationCallbackHandler.disposeCallback,
      iosSettings: const IOSSettings(
        accuracy: background_locator_2.LocationAccuracy.NAVIGATION,
        distanceFilter: 0,
        stopWithTerminate: true,
      ),
      autoStop: false,
      androidSettings: const AndroidSettings(
        accuracy: background_locator_2.LocationAccuracy.NAVIGATION,
        interval: 5,
        distanceFilter: 0,
        client: LocationClient.android,
        androidNotificationSettings: AndroidNotificationSettings(
          notificationChannelName: "Location tracking",
          notificationTitle: "Start Location Tracking",
          notificationMsg: "Track location in background",
          notificationBigMsg: "Background location is on to keep.",
          notificationIconColor: Colors.grey,
          notificationTapCallback: LocationCallbackHandler.notificationCallback,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            color: Colors.blue,
            onPressed: _startLocator,
            child: const Text(
              'Start',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CupertinoButton(
            color: Colors.black38,
            child: const Text(
              'End',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
