import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  // reusable 변수
  final String name, code, amount;
  final IconData icon;
  final bool isInverted; // 흑백 반전

  final _blackColor = const Color(0xFF1F2123); // 앞에 _를 붙이는건 private하게 사용하겠딴 의미~

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
  });

  @override
  Widget build(BuildContext context) {
    // 카드만들기
    return Container(
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
        ));
  }
}
