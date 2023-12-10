import 'package:call_log/call_log.dart';
import 'package:eta_frontend/model/dailyStatistics.dart';
import 'package:eta_frontend/view/static_main_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../model/diary.dart';
import '../model/event.dart';

class StaticDayView extends StatefulWidget {
  final DateTime date;
  final Event event;

  StaticDayView({required this.date, required this.event});

  @override
  State<StaticDayView> createState() => _StaticDayViewState();
}

class _StaticDayViewState extends State<StaticDayView> {
  DailyStatistics dailyStatistics =
      DailyStatistics(date: '2023-12-1', steps: 10000);
  List<Diary> diaries = [
    Diary(
        date: '2023/12/1',
        image: 'images/selfie.png',
        content: '제주도 여행!! 넘 재밌었다'),
    Diary(
        date: '2023/12/1',
        image: 'images/selfie2.png',
        content: '제주도 여행2!!개꿀잼'),
    //Diary(date: '2023/12/3',image: 'images/selfie.png', content: '제주도 여행!! 넘 재밌었다'),
    //Diary(date: '2023/12/5',image: 'images/selfie.png', content: '제주도 여행!! 넘 재밌었다')
  ];
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '${widget.date.year}년 ${widget.date.month}월 ${widget.date.day}일',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(132, 116, 247, 100),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Text('나의 발자취'),
                        // SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.hiking),
                            SizedBox(width: 10),
                            Text('${dailyStatistics.steps}걸음',
                                style: TextStyle(color: Colors.black)),
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
                            SizedBox(width: 10),
                            FutureBuilder<List<CallLogEntry>>(
                              future: getCallLogs(),
                              // 통화 기록을 가져오는 비동기 함수
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var callLogEntry in snapshot.data!)
                                        Text(
                                            '${(callLogEntry.timestamp != null) ? DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(callLogEntry.timestamp!)) : '시간접근불가'} ${callLogEntry.name}'),
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
                            Icon(Icons.thumb_up_alt),
                            SizedBox(width: 10),
                            Text(
                              '${widget.date.month}월 ${widget.date.day}일의 조언',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(132, 116, 247, 100),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${widget.date.month}월 ${widget.date.day}일은 목표치 걸음에 도달하였습니다. 멋지세요',
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
                            Icon(Icons.map_outlined),
                            SizedBox(width: 10),
                            Text(
                              '${widget.date.month}월 ${widget.date.day}일의 루트라인',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(132, 116, 247, 100),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                            height:300,
                            width: 300,
                            constraints: BoxConstraints.tightFor(width: 300, height: 300),
                            child: RouteLine()),
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
                              '${widget.date.month}월 ${widget.date.day}일 일기',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(132, 116, 247, 100),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            itemCount: diaries.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 16.0,
                                      color: Color(0xFF686868),
                                    ),
                                    Image.asset(
                                      diaries[index].image,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20.0),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            diaries[index].date,
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            diaries[index].content,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
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

class RouteLine extends StatefulWidget {
  const RouteLine({super.key});

  @override
  State<RouteLine> createState() => _RouteLineState();
}

class _RouteLineState extends State<RouteLine> {
  late NaverMapController _controller;
  final NMarker marker1 = NMarker(
      id: '1',
      position: NLatLng(33.406035981908, 126.33670567287),
      icon: NOverlayImage.fromAssetImage("images/selfie.png"), size:Size(50, 50));
  final NMarker marker2 = NMarker(
      id: '2',
      position: NLatLng(33.469642627187, 126.34043921252),
      icon: NOverlayImage.fromAssetImage("images/selfie2.png"), size:Size(50, 50));

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      onMapReady: (controller) {
        _controller = controller;
        _controller.addOverlay(marker1);
        _controller.addOverlay(marker2);
        NPathOverlay pathOverlay = NPathOverlay(id: "test", coords: [
          NLatLng(33.406035981908, 126.33670567287),
          NLatLng(33.469642627187, 126.34043921252)
        ],
          color: Color.fromRGBO(132, 116, 247, 100),
        );
        _controller.addOverlay(pathOverlay);
      },
      options: NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(
              target: NLatLng(33.406035981908, 126.33670567287), zoom: 10)),
    );
  }
}
