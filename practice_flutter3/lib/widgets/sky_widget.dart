import 'package:flutter/cupertino.dart';

class SkyWidget extends StatelessWidget {
  final String imgFileName;

  const SkyWidget({
    super.key,
    required this.imgFileName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Image(
          image: AssetImage("assets/images/$imgFileName.png"),
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
