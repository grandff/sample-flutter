import 'package:flutter/material.dart';
import 'package:practice_flutter3/utility/get_today.dart';
import 'package:practice_flutter3/widgets/sky_widget.dart';

class WeekWeather extends StatelessWidget {
  final String dayVal, tmxTmp, tmnTmp;
  final Future<String> imgFileName;
  const WeekWeather({
    super.key,
    required this.dayVal,
    required this.tmxTmp,
    required this.tmnTmp,
    required this.imgFileName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          DateUtility().getWeekdayFromString(dayVal),
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'SpoqaSans',
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: imgFileName,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SkyWidget(
                  imgFileName: snapshot.data!.toString(),
                  widthVal: 35,
                  heightVal: 35,
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        Text(
          '$tmxTmp/$tmnTmp',
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'SpoqaSans',
          ),
        ),
      ],
    );
  }
}
