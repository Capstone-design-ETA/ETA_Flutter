import 'package:eta_frontend/view/static_day_view.dart';
import 'model/event.dart';
import 'view/map_view.dart';
import 'package:eta_frontend/view/feeds_view.dart';
import 'package:eta_frontend/view/writing_view.dart';
import 'package:eta_frontend/view/static_main_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ETA',
      initialRoute: '/statics',
      routes: {
        //'/': (context) => MapView(),
        '/statics': (context) => StaticMainView(),
        '/statics/day': (context) {
          final arguments = ModalRoute.of(context)!.settings.arguments
              as Map<DateTime, dynamic>;
          final date = arguments['date'] as DateTime;
          final event = arguments['event'] as Event;
          return StaticDayView(date: date, event: event);
        },
        '/feeds': (context) => FeedsView(),
      },
    );
  }
}
