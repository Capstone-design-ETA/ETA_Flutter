import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StaticMainView extends StatefulWidget {
  const StaticMainView({super.key});

  @override
  State<StaticMainView> createState() => _StaticMainViewState();
}

class _StaticMainViewState extends State<StaticMainView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          title: Center(
            child: Text(
              '통계',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            CalendarScreen(),
            SizedBox(height: 40),
            ElevatedButton(
                onPressed: (){
                  _showPopup(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(138,60),
                  primary: Color.fromRGBO(88, 70, 245, 70),
                  onPrimary: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.5),
                  )

                ),
                child: Text('이달의 통계', style: TextStyle(
                  fontSize: 18,
                  ),
                ),
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
                      color: Color.fromRGBO(132,116,247,100),
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
                      color: Color.fromRGBO(132,116,247,100),
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
                      color: Color.fromRGBO(132,116,247,100),
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
                      color: Color.fromRGBO(132,116,247,100),
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
          title: Text('Popup Title'),
          content: Text('This is a simple popup.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
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
        todayTextStyle: TextStyle(
          color: Colors.black
        ),
        todayDecoration: BoxDecoration(
          color: null,
          shape: BoxShape.circle,
          border: Border.all(
            color: Color.fromRGBO(132,116,247,80),
            width: 2.0,
          ),
        )
      ),
    );
  }
}

