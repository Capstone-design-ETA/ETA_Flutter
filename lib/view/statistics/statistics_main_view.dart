import 'dart:collection';

import 'package:eta_frontend/permission.dart';
import 'package:eta_frontend/view/statistics/statistics_day_view.dart';
import 'package:eta_frontend/view/statistics/statistics_month_view.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/event.dart';

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
          child: Column(
            children: [
              CalendarScreen(),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  PopupDialog.showPopup(context);
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
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          type: BottomNavigationBarType.fixed,
          // currentIndex: _selectedIndex,
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
            DateTime selectedDate =
                DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
            //onselectedDay에 해당하는 이벤트가 _events맵에 존재하고 그 이벤트 목록이 비어있지 앟은 경우
            if (_events.containsKey(selectedDate) &&
                _events[selectedDate]!.isNotEmpty) {
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
            if (!isSameDay(_selectedDay, selectedDay)) {
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
