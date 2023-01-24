import 'package:flutter/cupertino.dart';

class SkyWidget extends StatelessWidget {
  final String imgFileName;
  final double widthVal;
  final double heightVal;

  const SkyWidget({
    super.key,
    required this.imgFileName,
    required this.widthVal,
    required this.heightVal,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Image(
          image: AssetImage("assets/images/$imgFileName.png"),
          width: widthVal,
          height: heightVal,
        ),
      ),
    );
  }
}
