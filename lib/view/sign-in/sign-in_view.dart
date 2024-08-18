import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';
import 'google_sign_in_eta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;

class SignInView extends StatelessWidget {
  // const SignInView({super.key});

  void _signInWithGoogle(context) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => OAuthWebView()),
    );
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
              // 구글 로그인
              // onPressed: () {
              //   // signUpWithGoogle();
              //   // sendPostRequest();
              //   googleLogin();
              //   // googlesignin();
              // },
              onPressed: () => _signInWithGoogle(context),
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

class OAuthLoginPage extends StatefulWidget {
  @override
  _OAuthLoginPageState createState() => _OAuthLoginPageState();
}

class _OAuthLoginPageState extends State<OAuthLoginPage> {
  final _storage = FlutterSecureStorage();
  final _controller = WebviewController();
  bool _isWebViewReady = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (Platform.isWindows) {
      await _controller.initialize();
      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller
          .loadUrl('http://192.168.208.1:8080/oauth2/authorization/google');

      // _controller.addListener(() {
      //   if (_controller.value.url
      //       .startsWith('http://localhost:8080/api/user/jwt-test')) {
      //     Uri uri = Uri.parse(_controller.value.url);
      //     String accessToken = uri.queryParameters['accessToken'] ?? '';
      //     if (accessToken.isNotEmpty) {
      //       _saveTokenAndNavigateHome(context, accessToken);
      //     }
      //   }
      // });

      if (!mounted) return;
      setState(() {
        _isWebViewReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OAuth Login')),
      body: Platform.isWindows
          ? (_isWebViewReady
              ? Webview(_controller)
              : Center(child: CircularProgressIndicator()))
          : WebView(
              initialUrl:
                  'http://192.168.208.1:8080/oauth2/authorization/google',
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith(
                    'http://192.168.208.1:8080/api/user/jwt-test')) {
                  Uri uri = Uri.parse(request.url);
                  String accessToken = uri.queryParameters['accessToken'] ?? '';
                  if (accessToken.isNotEmpty) {
                    _saveTokenAndNavigateHome(context, accessToken);
                  }
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
    );
  }

  void _saveTokenAndNavigateHome(BuildContext context, String token) async {
    // 토큰을 안전하게 저장
    await _storage.write(key: 'jwt_token', value: token);
    // 로그인 성공 후 넘어가야 하는 화면으로 이동
    Navigator.of(context).pushReplacementNamed('/feeds');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class OAuthWebView extends StatefulWidget {
  @override
  _OAuthWebViewState createState() => _OAuthWebViewState();
}

class _OAuthWebViewState extends State<OAuthWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OAuth2 Authorization'),
      ),
      body: WebView(
        initialUrl: 'http://192.168.1.126:8080/login',
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        onWebViewCreated: (WebViewController webViewController) {
          // WebViewController 설정 (필요 시)
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('http://192.168.1.126:8080/redirect')) {
            // OAuth 인증 후 리디렉션을 처리하는 로직 추가
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
      ),
    );
  }
}
