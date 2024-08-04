import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final storage = FlutterSecureStorage();
  final String _baseUrl = 'http://localhost:8080'; // 백엔드 URL

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

// 백엔드로 ID 토큰 전송
      final response = await http.post(
        Uri.parse('http://localhost:8080/oauth/google'),
        body: {'id_token': googleAuth.idToken},
      );

      if (response.statusCode == 200) {
        final jwt = json.decode(response.body)['access_token'];
        await storage.write(key: 'jwt_token', value: jwt);
        return jwt;
      } else {
        throw Exception('Failed to sign in with Google');
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await storage.delete(key: 'jwt_token');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }
}

class ApiService {
  final AuthService _authService;

  ApiService(this._authService);

  Future<dynamic> jwtTest() async {
    final token = await _authService.getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('http://localhost:8080/api/user/jwt-test?accessToken=$token'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to test JWT: ${response.statusCode}');
    }
  }
}

class SignInView extends StatelessWidget {
  const SignInView({super.key});

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

  final ApiService _apiService = ApiService(AuthService());

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
              onPressed: () async {
                try {
                  final result = await _apiService.jwtTest();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('JWT Test successful: $result')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('JWT Test failed: $e')),
                  );
                }
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
}
