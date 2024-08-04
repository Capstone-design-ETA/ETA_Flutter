import 'dart:collection';

import 'package:eta_frontend/permission.dart';
import 'package:eta_frontend/view/static_day_view.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

import '../model/event.dart';

class StaticMainView extends StatefulWidget {
  const StaticMainView({super.key});

  @override
  State<StaticMainView> createState() => _StaticMainViewState();
}

class _StaticMainViewState extends State<StaticMainView> {
  void initState() {
    super.initState();
    requestPermissions();
  }

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
  int _selectedIndex = 2;


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
              color: Color.fromRGBO(132, 116, 247, 100),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child : Column(
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
              // PermissionRequestButton(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
                  // // ElevatedButton(
                  // //   onPressed: () {
                  // //     Navigator.push(
                  // //       context,
                  // //       // MaterialPageRoute(
                  // //         // builder: (context) => StaticDayView(),
                  // //       ),
                  // //     );
                  // //   },
                  // //   style: ElevatedButton.styleFrom(
                  // //     fixedSize: Size(138, 60),
                  // //     primary: Color.fromRGBO(88, 70, 245, 70),
                  // //     onPrimary: Colors.white,
                  // //     elevation: 4,
                  // //     padding: EdgeInsets.all(8),
                  // //     shape: CircleBorder(),
                  // //   ),
                  //   /*shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(14.5),
                  //       ))*/
                  //   child: Text(
                  //     '+',
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //     ),
                  //   ),
                  // ),
                //],
              //)
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            // 선택된 탭에 대한 동작 수행
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/map');
                break;
              case 1:
                Navigator.pushNamed(context, '/writing');
                break;
              case 2:
                Navigator.pushNamed(context, '/statics');
                break;
              case 3:
                Navigator.pushNamed(context, '/map');
                break;
            }
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0; // 탭이 선택되었을 때 _selectedIndex 업데이트
                  });
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
                  setState(() {
                    _selectedIndex = 1; // 탭이 선택되었을 때 _selectedIndex 업데이트
                  });
                 Navigator.pushNamed(context, '/writing');
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
                  setState(() {
                    _selectedIndex = 2; // 탭이 선택되었을 때 _selectedIndex 업데이트
                  });
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
                  setState(() {
                    _selectedIndex = 3; // 탭이 선택되었을 때 _selectedIndex 업데이트
                  });
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
          title: Text('2023년 12월 통계', style: TextStyle(
            color: Color.fromRGBO(132, 116, 247, 100),
            fontWeight: FontWeight.bold
          ),),
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
                            // Row(
                            //   children: [
                            //     Icon(Icons.location_on),
                            //     SizedBox(width: 5),
                            //     Expanded(
                            //       child: Text(
                            //         '2023년 12월은 총 8군데를 방문하였어요!',
                            //         style: TextStyle(color: Colors.green),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     Icon(Icons.call),
                            //     SizedBox(width: 5),
                            //     Expanded(
                            //       child: Text(
                            //         '2023년 12월은 집전화, Oh JImin, 엄마와 가장 전화를 많이 하였어요!',
                            //         style: TextStyle(color: Colors.red),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
                                    Image.asset("images/gold.png", width: 30, height: 30),
                                    SizedBox(height: 3),
                                    Text("엄마")
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Image.asset("images/silver.png",width: 30, height: 30),
                                    SizedBox(height: 3),
                                    Text("집전화")
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Image.asset("images/bronze.png",width: 30, height: 30),
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
                              labels: ['용인\n30%', '수원\n25%', '제주도\n20%', '서울\n25%'],
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
              child: Text('X', style: TextStyle(
                color: Color.fromRGBO(132, 116, 247, 100),
              ),),
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
  Map<DateTime, List<Event>> _events = {
    DateTime(2023, 12, 1): [Event(date: DateTime(2023, 12, 1))]
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
            DateTime selectedDate = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
            //onselectedDay에 해당하는 이벤트가 _events맵에 존재하고 그 이벤트 목록이 비어있지 앟은 경우
            if (_events.containsKey(selectedDate) && _events[selectedDate]!.isNotEmpty) {
              print(selectedDate);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StaticDayView(
                    date: selectedDate,
                    event: _events[selectedDate]!.first,
                  ),
                ),
              );
            }
            if(!isSameDay(_selectedDay, selectedDay)){
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
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
          calendarBuilders: CalendarBuilders(
            // Event Marker
            markerBuilder: (context, date, events) {
              DateTime _date = DateTime(date.year, date.month, date.day);
              if (_events.containsKey(_date) && _events[_date]!.isNotEmpty) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.11,
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(132, 116, 247, 80),
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(height: 16),
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
      textAlign: TextAlign.center
    );

    textPainter.layout();

    final double textX = centerX + (x - centerX) - textPainter.width / 2;
    final double textY = centerY + (y - centerY) - textPainter.height / 2;

    textPainter.paint(
        canvas, Offset(textX, textY)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
