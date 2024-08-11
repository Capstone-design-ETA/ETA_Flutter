import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInView extends StatelessWidget {
  // const SignInView({super.key});

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
              // 구글 로그인
              onPressed: () {
                // signUpWithGoogle();
                sendPostRequest();
              },
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

  Future<void> signUpWithGoogle() async {
    // 백엔드로 토큰 전송 및 사용자 등록 로직 구현
    // 예: HTTP POST 요청을 통해 토큰과 함께 사용자 정보를 백엔드로 전송
    // 백엔드는 이 정보를 사용하여 사용자가 새로운 사용자인지 확인하고, 새로운 사용자라면 회원가입 처리를 합니다.
    // final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    // final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    final url = Uri.parse('http://localhost:8080/oauth2/authorization/google');
    try {
      // http request
      // final accessToken = googleSignInAuthentication.accessToken;
      // print(accessToken);
      final response = await http.post(
          // 예시 IP 주소
          url, // API URL
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer $accessToken'
          });
      // if response is OK
      if (response.statusCode == 200) {
        // Spring Security 에서 발급해준 토큰을 저장
        final storage = FlutterSecureStorage();
        final responseData = json.decode(response.body);
        final String token = responseData['token'];
        await storage.write(key: 'token', value: token);
      } else {
        // error handling required
        debugPrint("로그인에 실패했습니다!");
      }
    } catch (e) {
      // networ error handling required
      debugPrint("서버와의 접속이 끊겼습니다!");
    }
  }

  Future<void> sendPostRequest() async {
    final url = Uri.parse('http://localhost:8080/oauth2/authorization/google');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: '{}', // 필요에 따라 본문 데이터를 추가하세요.
      );

      if (response.statusCode == 200) {
        print('Request was successful: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}

// final GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: [
//     'email',
//     // 필요한 추가 스코프를 여기에 추가하세요
//   ],
// );


