
import 'package:flutter/material.dart';

class StaticDayView extends StatefulWidget {
  const StaticDayView({super.key});

  @override
  State<StaticDayView> createState() => _StaticDayViewState();
}

class _StaticDayViewState extends State<StaticDayView> {
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
                        '2023년 1월 15일',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('나의 발자취'),
                      Text('걸음수: 10,000 보', style: TextStyle(color: Colors.green)),
                      Text('칼로리 소모: 500 Kcal', style: TextStyle(color: Colors.red)),
                      Text('통화 기록: 30분', style: TextStyle(color: Colors.blue)),
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
                      Text(
                        '일기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
      ),
    );
  }
}
