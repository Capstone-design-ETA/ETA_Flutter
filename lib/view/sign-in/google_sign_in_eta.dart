import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final url = Uri.parse(
      'http://localhost:3032/oauth2/authorization/google?redirect_uri=http://localhost:3032/login/oauth2/code/google');

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

// final GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: [
//     'email',
//     // 필요한 추가 스코프를 여기에 추가하세요
//   ],
// );

Future<void> googlesignin() async {
  GoogleSignInAccount? user;
  final clientid =
      '654187401153-c3p6ja239hdca9rtp4bt3cbl0b2332rg.apps.googleusercontent.com';
  GoogleSignIn googleuser = GoogleSignIn(
    clientId: clientid,
  );
  googleuser.signInSilently();
}

Future<void> googleLogin() async {
  var googleLoginHelper = new GoogleLoginHelper();

  googleLoginHelper.login();
  googleLoginHelper._handleSignOut();

  // .then((accessToken) {
  //   log('accessToken: $accessToken');

  // if (accessToken == null) {
  //   EasyLoading.showError('로그인/회원가입에 실패했습니다.',
  //       duration: const Duration(seconds: 3),
  //       maskType: EasyLoadingMaskType.black,
  //       dismissOnTap: false);
  //   return;
  // }

  // autoLogin(accessToken, LoginPlatform.GOOGLE)
  //     .then((value) => afterLogin(value))
  //     .then((value) => googleLoginHelper.logout(accessToken));
  // });
}

class GoogleLoginHelper {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId:
        '654187401153-o770kdb8r8l9mlapcb8m3f35555k4dsl.apps.googleusercontent.com',
  );

  Future<String?> login() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      print(googleSignInAuthentication.accessToken);

      return googleSignInAuthentication.accessToken;
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  Future<void> logout(String? accessToken) async {
    await revokeToken(accessToken!);

    await googleSignIn.signOut();
    print('User signed out');
  }

  Future<void> revokeToken(String token) async {
    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/revoke'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'token=$token',
    );

    if (response.statusCode == 200) {
      print('Token revoked successfully');
    } else {
      print('Failed to revoke token');
    }
  }
}
