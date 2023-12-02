import 'package:eta_frontend/view/sign-in_view.dart';
import 'package:eta_frontend/view/sign-up1_view.dart';
import 'package:eta_frontend/view/sign-up2_view.dart';
import 'package:eta_frontend/view/sign-up3_view.dart';
import 'package:eta_frontend/view/sign-up_body_view.dart';
import 'package:eta_frontend/view/static_day_view.dart';
import 'view/map_view.dart';
import 'package:eta_frontend/view/feeds_view.dart';
import 'package:eta_frontend/view/writing_view.dart';
import 'package:eta_frontend/view/static_main_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ETA',
      initialRoute: '/writing',
      routes: {
        '/sign-in': (context) => SignInView(),
        '/sign-up/body': (context) => SignupBodyView(),
        '/sign-up1': (context) => SignUp1View(),
        '/sign-up2': (context) => SignUp2View(),
        '/sign-up3': (context) => SignUp3View(),
        '/map': (context) => MapView(),
        '/statics': (context) => StaticMainView(),
        '/statics/day': (context) => StaticDayView(),
        '/feeds': (context) => FeedsView(),
        '/writing': (context) => WritingView(),
      },
    );
  }
}
