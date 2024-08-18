import 'dart:math';
import 'package:flutter/material.dart';

class PopupDialog {
  static void showPopup(BuildContext context) {
    /**
   * 월별 통계 정보
   */
    Map<String, double> dataMap = {
      "용인": 5,
      "서울": 3,
      "수원": 2,
      "제주도": 2,
    };

    final colorList = <Color>[
      Color.fromRGBO(96, 89, 247, 1),
      Color.fromRGBO(101, 146, 254, 1),
      Color.fromRGBO(54, 195, 254, 1),
      Color.fromRGBO(140, 97, 255, 1),
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '2023년 12월 통계',
            style: TextStyle(
                color: Color.fromRGBO(233, 230, 255, 0.612),
                fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.hiking),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    '평균 5210걸음',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.call),
                                SizedBox(width: 5),
                                Text("월간 통화 Top3"),
                              ],
                            ),
                            SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Image.asset("images/gold.png",
                                        width: 30, height: 30),
                                    SizedBox(height: 3),
                                    Text("엄마")
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Image.asset("images/silver.png",
                                        width: 30, height: 30),
                                    SizedBox(height: 3),
                                    Text("집전화")
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Image.asset("images/bronze.png",
                                        width: 30, height: 30),
                                    SizedBox(height: 3),
                                    Text("아빠")
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '내 방문지역',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: PieChart(
                              size: 200.0,
                              values: [30.0, 25.0, 20.0, 25.0],
                              colors: [
                                Color.fromRGBO(96, 89, 247, 1),
                                Color.fromRGBO(101, 146, 254, 1),
                                Color.fromRGBO(54, 195, 254, 1),
                                Color.fromRGBO(140, 97, 255, 1),
                              ],
                              labels: [
                                '용인\n30%',
                                '수원\n25%',
                                '제주도\n20%',
                                '서울\n25%'
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  '총 8군데를 방문하였어요!',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'X',
                style: TextStyle(
                  color: Color.fromRGBO(132, 116, 247, 100),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/*
 원형 차트
 */
class PieChart extends StatelessWidget {
  final double size;
  final List<double> values;
  final List<Color> colors;
  final List<String> labels;

  PieChart(
      {required this.size,
      required this.values,
      required this.colors,
      required this.labels});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: PieChartPainter(values, colors, labels),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  final List<String> labels;

  PieChartPainter(this.values, this.colors, this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    double total = values.reduce((value, element) => value + element);
    double startAngle = 0.0;

    for (int i = 0; i < values.length; i++) {
      double sectionAngle = (values[i] / total) * 2.0 * pi;
      drawArc(canvas, size, startAngle, sectionAngle, colors[i]);
      drawText(canvas, size, startAngle + sectionAngle / 2, labels[i]);
      startAngle += sectionAngle;
    }
  }

  void drawArc(Canvas canvas, Size size, double startAngle, double sweepAngle,
      Color color) {
    final Rect rect = Rect.fromCircle(
        center: size.center(Offset.zero), radius: size.width / 2);
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  void drawText(Canvas canvas, Size size, double angle, String text) {
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double textRadius = radius * 0.8;

    final double x = centerX + textRadius * cos(angle);
    final double y = centerY + textRadius * sin(angle);

    final TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
      //fontWeight: FontWeight.bold,
    );

    final TextSpan span = TextSpan(
      text: text,
      style: textStyle,
    );

    final TextPainter textPainter = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);

    textPainter.layout();

    final double textX = centerX + (x - centerX) - textPainter.width / 2;
    final double textY = centerY + (y - centerY) - textPainter.height / 2;

    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
