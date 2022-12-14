import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget{  // core 위젯 중 하나를 상속받음
  @override
  Widget build(BuildContext context){
    // 메인 테마 설정
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title : Text('Hello Flutter')
        ),
        body: Text('Hello World!'),
      ),
    );
  }
}
