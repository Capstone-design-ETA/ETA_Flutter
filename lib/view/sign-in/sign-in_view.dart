import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInView extends StatelessWidget {
  // const SignInView({super.key});

  // void signInWithGoogle(context) async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   if (googleUser != null) {
  //     Navigator.pushNamed(context, '/sign-up');
  //   }
  // }

  void signInWithGoogle(BuildContext context) async {
// // 클라이언트 ID와 리다이렉트 URL을 기입합니다.
    final String googleClientId =
        "654187401153-e24j689kuup16v4n4jsoj3bc551r87fv.apps.googleusercontent.com";
    final String callbackUrlScheme =
        'com.googleusercontent.apps.654187401153-e24j689kuup16v4n4jsoj3bc551r87fv';

    try {
      final authUrl = Uri.https(
        'accounts.google.com',
        '/o/oauth2/v2/auth',
        {
          'response_type': 'code',
          'client_id': googleClientId,
          'redirect_uri': '$callbackUrlScheme:/',
          'scope': 'email',
        },
      );
      debugPrint(authUrl.toString());

      final result = await FlutterWebAuth2.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: callbackUrlScheme,
      );
      debugPrint("paso");
      debugPrint(result);
      final code = Uri.parse(result).queryParameters['code'];

      final tokenUrl = Uri.https('oauth2.googleapis.com', '/token');

      final response = await http.post(
        tokenUrl,
        body: {
          // 'client_id': googleClientId,
          // 'redirect_uri': '$callbackUrlScheme:/',
          // 'grant_type': 'authorization_code',
          'code': code,
        },
      );

      // final accessToken = jsonDecode(response.body)['access_token'] as String;
      // final idToken =
      // jsonDecode(response.body)['id_token'] as String;
      //
      // debugPrint('Access Token: $accessToken');
      // debugPrint('ID Token: $idToken');
    } catch (e) {
      debugPrint('Error during Google login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '여행을 신나게\n원빈이와 여행을!',
              style: TextStyle(
                fontSize: 29.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            ElevatedButton(
              // onPressed: () {
              //   signInWithGoogle(context);
              // },
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(53.0),
                  primary: Color(0xFFFFFFFF),
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: BorderSide(width: 0.1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'images/glogo.png',
                  ),
                  Text(
                    '구글로 로그인',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: Image.asset(
                      'images/glogo.png',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(53.0),
                  primary: Color(0xFFFEE500),
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'images/klogo.png',
                  ),
                  Text(
                    '카카오톡으로 로그인',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: Image.asset(
                      'images/klogo.png',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
