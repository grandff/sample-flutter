import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:practice_flutter4/features/navigation/main_navigation_screen.dart';

void main() async {
  // env 파일 경로 설정
  await dotenv.load(fileName: 'lib/assets/config/.env');
  // naver map setting
  WidgetsFlutterBinding.ensureInitialized();
  var naverClientId = dotenv.env['NAVER_MAP_CLIENT_ID'];
  await NaverMapSdk.instance.initialize(clientId: naverClientId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}
