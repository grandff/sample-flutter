import 'package:flutter/material.dart';
import 'package:practice_flutter3/utility/get_today.dart';

class AlertScreen extends StatefulWidget {
  final List<String> t6, t7, other; // 특보 데이터
  final String tmEf; // 특보발효현황시각
  final int tmFc; // 발표시각
  const AlertScreen({
    super.key,
    required this.t6,
    required this.t7,
    required this.other,
    required this.tmEf,
    required this.tmFc,
  });

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  late Map<String, dynamic> t6Map = {};
  late Map<String, dynamic> t7Map = {};
  late Map<String, dynamic> other = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '기상특보',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'SpoqaSans',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
              child: Text(
                DateUtility().changeDateFormat(widget.tmEf),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  fontFamily: 'SpoqaSans',
                ),
              ),
            ), // 발효현황시각
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.t6.length,
                itemBuilder: ((context, index) {
                  var tempData = widget.t6[index].split(" : ");
                  return Container(
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
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ExpansionTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.speaker_phone_rounded,
                            size: 25,
                          ),
                          Text(
                            tempData[0].replaceAll("o ", ""),
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'SpoqaSans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tempData[1],
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: 'SpoqaSans',
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                "${DateUtility().changeDateFormat(widget.tmFc.toString())} 기준",
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'SpoqaSans',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ), // 발표시각 (오른쪽하단 회색으로)
          ],
        ),
      ),
    );
  }
}
