import 'package:eta_frontend/view/sign-in/sign-in_view.dart';
import 'package:eta_frontend/view/sign-in/sign-up_body_view.dart';
import 'package:eta_frontend/view/static_day_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'view/map/map_view.dart';
import 'package:eta_frontend/view/feeds_view.dart';
import 'package:eta_frontend/view/writing_view.dart';
import 'package:eta_frontend/view/static_main_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  //네이버 지도 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: '29o5emcbkh',
      onAuthFailed: (ex) {
        print("********* 네이버맵 인증오류 : $ex *********");
      });

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
      initialRoute: '/map',
      routes: {
        '/sign-in': (context) => SignInView(),
        '/sign-up': (context) => SignupBodyView(),
        '/map': (context) => MapView(),
        '/statics': (context) => StaticMainView(),
        '/statics/day': (context) => StaticDayView(),
        '/feeds': (context) => FeedsView(),
        '/writing': (context) => WritingView(),
      },
    );
  }
}
