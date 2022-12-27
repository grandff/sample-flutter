import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  // reusable 변수
  final String name, code, amount;
  final IconData icon;
  final bool isInverted; // 흑백 반전
  final int order;

  final _blackColor = const Color(0xFF1F2123); // 앞에 _를 붙이는건 private하게 사용하겠딴 의미~
  final _orderFirst = const Offset(0, 0);
  final _orderSecond = const Offset(0, -30);
  final _orderThird = const Offset(0, -60);

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    // 카드만들기
    return Transform.translate(
      offset: order == 1
          ? _orderFirst
          : order == 2
              ? _orderSecond
              : _orderThird,
      child: Container(
          clipBehavior: Clip.hardEdge, // overflow hidden 같은 거임.. 아마도.
          decoration: BoxDecoration(
            color: isInverted ? Colors.white : _blackColor,
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
                    Text(
                      name,
                      style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(amount,
                            style: TextStyle(
                              color: isInverted ? _blackColor : Colors.white,
                              fontSize: 20,
                            )),
                        const SizedBox(width: 5),
                        Text(code,
                            style: TextStyle(
                              color: isInverted
                                  ? _blackColor
                                  : Colors.white.withOpacity(0.8),
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
                    child: Icon(
                      icon,
                      color: isInverted ? _blackColor : Colors.white,
                      size: 88,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
