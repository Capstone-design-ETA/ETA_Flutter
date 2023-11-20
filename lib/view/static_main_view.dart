import 'package:eta_frontend/view/static_day_view.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

class StaticMainView extends StatefulWidget {
  const StaticMainView({super.key});

  @override
  State<StaticMainView> createState() => _StaticMainViewState();
}

class _StaticMainViewState extends State<StaticMainView> {
  Map<String, double> dataMap = {
    "용인": 5,
    "서울": 3,
    "수원": 2,
    "제주도": 2,
  };

  final colorList = <Color>[
    Colors.lightGreen,
    Colors.blue,
    Colors.orangeAccent,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          title: Text(
            '통계',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            CalendarScreen(),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _showPopup(context);
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(138, 60),
                  primary: Color.fromRGBO(88, 70, 245, 70),
                  onPrimary: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.5),
                  )),
              child: Text(
                '이달의 통계',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaticDayView(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(138, 60),
                      primary: Color.fromRGBO(88, 70, 245, 70),
                      onPrimary: Colors.white,
                      elevation: 4,
                      padding: EdgeInsets.all(8),
                      shape: CircleBorder(),),
                      /*shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.5),
                      ))*/
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/map');
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color.fromRGBO(132, 116, 247, 100),
                    ),
                  ],
                ),
              ),
              label: '지도',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StaticMainView(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.edit_note,
                      color: Color.fromRGBO(132, 116, 247, 100),
                    ),
                  ],
                ),
              ),
              label: '기록',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StaticMainView(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.analytics,
                      color: Color.fromRGBO(132, 116, 247, 100),
                    ),
                  ],
                ),
              ),
              label: '통계',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StaticMainView(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Color.fromRGBO(132, 116, 247, 100),
                    ),
                  ],
                ),
              ),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('이달의 통계'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '2023년 11월',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.hiking),
                                Expanded(
                                    child: Text('2023년 11월은 평균 10,000걸음을 걸었군요!',
                                      style: TextStyle(color: Colors.black),
                                    ),),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                Expanded(
                                    child: Text('2023년 11월은 총 18군데를 방문하였어요!',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.call),
                                Expanded(
                                    child: Text('2023년 11월은 엄마, 아빠, 학교와 가장 전화를 많이 하였어요!',
                                      style: TextStyle(color: Colors.red),
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
                                Colors.red,
                                Colors.green,
                                Colors.blue,
                                Colors.orange
                              ],
                              labels: ['용인', '수원', '제주도', '서울'],
                            ),
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
              child: Text('X'),
            ),
          ],
        );
      },
    );
  }
}

/*
  캘린더
 */
class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _events = {
    DateTime(2023, 11, 8): ['Event A', 'Event B'],
    DateTime(2023, 11, 12): ['Event C'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          locale: 'ko_KR',
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
          },
          eventLoader: (day) {
            return _events[day] ?? [];
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          //캘린더 헤더 스타일
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
            leftChevronIcon: const Icon(
              Icons.arrow_left,
              size: 40.0,
            ),
            rightChevronIcon: const Icon(
              Icons.arrow_right,
              size: 40.0,
            ),
          ),
          calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.black),
              todayDecoration: BoxDecoration(
                color: null,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromRGBO(132, 116, 247, 80),
                  width: 2.0,
                ),
              )),
        ),
        SizedBox(height: 16),
        if (_selectedDay != null && _events.containsKey(_selectedDay))
          _buildEventCircle(),
      ],
    );
  }

  Widget _buildEventCircle() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red, // 동그란 원의 색상
          ),
        ),
        Text(
          '${_events[_selectedDay]?.length ?? 0}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    final TextSpan span = TextSpan(
      text: text,
      style: textStyle,
    );

    final TextPainter textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    textPainter.paint(
        canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
