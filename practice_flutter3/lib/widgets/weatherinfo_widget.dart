import 'package:flutter/material.dart';

class WeatherDetailInfo extends StatelessWidget {
  final String wsd; // 풍속
  final String pcp; // 강수량
  final String reh; // 습도

  const WeatherDetailInfo({
    Key? key,
    required this.wsd,
    required this.pcp,
    required this.reh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 25,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(5, 5),
            color: Colors.grey.withOpacity(0.4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Image(
                image: AssetImage("assets/images/info/info_wind.png"),
                width: 30,
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                wsd,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'SpoqaSans',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "풍속",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'SpoqaSans',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Image(
                image: AssetImage("assets/images/info/info_pre.png"),
                width: 30,
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                (pcp == "강수없음mm" ? "강수없음" : pcp),
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'SpoqaSans',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "강수량",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'SpoqaSans',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Image(
                image: AssetImage("assets/images/info/info_humi.png"),
                width: 30,
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                reh,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'SpoqaSans',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "습도",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'SpoqaSans',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
