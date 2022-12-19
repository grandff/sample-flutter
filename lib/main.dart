import 'package:flutter/material.dart';
import 'package:sample_flutter/widgets/Buttons.dart';
import 'package:sample_flutter/widgets/currency_card.dart';

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
        body: SingleChildScrollView(
          child: Padding(
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
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
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
                // card
                const CurrencyCard(
                  name: "Euro",
                  code: "EUR",
                  amount: "6 428",
                  icon: Icons.euro_rounded,
                  isInverted: false,
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: const CurrencyCard(
                    name: "Bitcoin",
                    code: "BTC",
                    amount: "9 785",
                    icon: Icons.currency_bitcoin,
                    isInverted: true,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -60),
                  child: const CurrencyCard(
                    name: "Dollar",
                    code: "USD",
                    amount: "428",
                    icon: Icons.attach_money_outlined,
                    isInverted: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
