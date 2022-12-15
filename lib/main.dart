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
        backgroundColor: Color(0xFF181818),   // 커스텀배경색지정. 0xFF 로 시작
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40
          ),  
          child: Column(
            children: [
              SizedBox( // 말그대로 사이즈가 있는 박스.. div같은
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // 해당 ROW의 요소들을 맨끝으로 정렬
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // 텍스트의 끝으로 정렬. 이 옵션을 안주면 두번쨰의 Welcome back 정렬이 이상해짐
                    children: [
                    Text('Hey, Selena',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Text('Welcome back',
                      style: TextStyle(
                        color:Colors.white.withOpacity(0.8),
                        fontSize: 18
                      ),
                    ),
                  ],)
                ],
              )
            ],
          ),
        )
        
      ),
    );
  }
}
