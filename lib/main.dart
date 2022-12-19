import 'package:flutter/material.dart';
import 'package:sample_flutter/widgets/Buttons.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // core 위젯 중 하나를 상속받음
  @override
  Widget build(BuildContext context) {
    // 메인 테마 설정
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818), // 커스텀배경색지정. 0xFF 로 시작
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Total Balacne 쪽은 왼쪽정렬로 처리
            children: [
              const SizedBox(
                // 말그대로 사이즈가 있는 박스.. div같은
                height: 80,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // 해당 ROW의 요소들을 맨끝으로 정렬
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .end, // 텍스트의 끝으로 정렬. 이 옵션을 안주면 두번쨰의 Welcome back 정렬이 이상해짐
                    children: [
                      const Text(
                        'Hey, Selena',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        'Welcome back',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8), fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 120,
              ),
              Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '\$5 194 482',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Button(
                    // 재사용할 위젯으로 바꾸기
                    text: 'Transfer',
                    bgColor: Colors.amber,
                    textColor: Colors.black,
                  ),
                  Button(
                    text: 'Request',
                    bgColor: Color(0xFF1F2123),
                    textColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ), // 버튼과 Wallet 사이 간격
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Wallets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      )),
                  Text('View All',
                      style: TextStyle(
                        color: Colors.white.withOpacity(
                            0.8), // withOpacity는 컴파일 단계에서 알 수 없으므로 const가 붙으면 안됨. 자동완성 시 이런 문제가 생길 수 있으니 참고.
                        fontSize: 18,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // 카드만들기
              Container(
                  clipBehavior: Clip.hardEdge, // overflow hidden 같은 거임.. 아마도.
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2123),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Euro',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text('6 428',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                                const SizedBox(width: 5),
                                Text('EUR',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Transform.scale(
                          // 아이콘 크기 변경
                          scale: 2.2,
                          child: Transform.translate(
                            // 아이콘 위치 변경
                            offset: const Offset(-5, 12),
                            child: const Icon(
                              Icons.euro_rounded,
                              color: Colors.white,
                              size: 88,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
