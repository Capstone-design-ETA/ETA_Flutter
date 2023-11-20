import 'package:eta_frontend/view/sign-in_view.dart';
import 'package:eta_frontend/view/sign-up1_view.dart';
import 'package:eta_frontend/view/sign-up2_view.dart';
import 'package:eta_frontend/view/sign-up3_view.dart';

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
      initialRoute: '/sign-up1',
      routes: {
        '/sign-in': (context) => SignInView(),
        '/sign-up1': (context) => SignUp1View(),
        '/sign-up2': (context) => SignUp2View(),
        '/sign-up3': (context) => SignUp3View(),
        '/map': (context) => MapView(),
        '/staticmain': (context) => StaticMainView(),
        '/feeds': (context) => FeedsView(),
      },
    );
  }
}
