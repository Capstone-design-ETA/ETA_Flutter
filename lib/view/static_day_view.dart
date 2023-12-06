import 'package:call_log/call_log.dart';
import 'package:eta_frontend/model/dailyStatistics.dart';
import 'package:eta_frontend/view/static_main_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/event.dart';


class StaticDayView extends StatefulWidget {
  final DateTime date;
  final Event event;
  StaticDayView({required this.date, required this.event});

  @override
  State<StaticDayView> createState() => _StaticDayViewState();
}

class _StaticDayViewState extends State<StaticDayView> {
  DailyStatistics dailyStatistics = DailyStatistics(
      date: '2023-12-1', steps: 10000);
  Future<PermissionStatus> permission = Permission.phone.status;

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
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${widget.date.year}년 ${widget.date.month}월 ${widget
                            .date.day}일',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Text('나의 발자취'),
                      // SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.hiking),
                          SizedBox(width: 10),
                          Text('${dailyStatistics.steps}걸음', style: TextStyle(
                              color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department),
                          SizedBox(width: 10),
                          Text('${dailyStatistics.steps * 0.05} Kcal',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.call),
                          SizedBox(width: 10),
                          Text('통화 기록 \n'),
                          FutureBuilder<List<CallLogEntry>>(
                            future: getCallLogs(),
                            // 통화 기록을 가져오는 비동기 함수 (적절히 수정 필요)
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
                              } else if (snapshot.hasError) {
                                return Text('에러 발생: ${snapshot.error}');
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                // 통화 기록이 있는 경우
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var callLogEntry in snapshot.data!)
                                      Text(
                                          '${(callLogEntry.timestamp != null) ? DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(callLogEntry.timestamp!)): '시간접근불가'} ${callLogEntry.name}'),
                                  ],
                                );
                              } else {
                                // 통화 기록이 없는 경우
                                return Text('통화 기록이 없습니다.');
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.event_note),
                          SizedBox(width: 10),
                          Text(
                            '일기',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '오늘은 좋은 날이었습니다. 맑은 하늘과 함께 산책을 즐겼어요.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
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

  Future<List<CallLogEntry>> getCallLogs() async {
    PermissionStatus permissionStatus = await Permission.phone.status;
    if (permissionStatus.isGranted) {
      Iterable<CallLogEntry> callLogsIterable = await CallLog.get();
      return callLogsIterable.toList();
    } else {
      return [];
    }
  }
}
