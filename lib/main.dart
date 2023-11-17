import 'package:eta_frontend/view/feeds_view.dart';
import 'package:eta_frontend/view/writing_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ETA',
      initialRoute: '/feeds',
      routes: {
        '/feeds': (context) => FeedsView(),

      },
    );
  }
}
