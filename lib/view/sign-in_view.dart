import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  void signInWithGoogle(context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      Navigator.pushNamed(context, '/nickname');
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
            SizedBox(height: 100.0,),
            ElevatedButton(
              onPressed: (){
                signInWithGoogle(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromHeight(53.0),
                primary: Color(0xFFFFFFFF),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                side: BorderSide(width: 0.1)
              ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('images/glogo.png',),
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
                      child: Image.asset('images/glogo.png',),
                    ),
                  ],
                ),
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(53.0),
                  primary: Color(0xFFFEE500),
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('images/klogo.png',),
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
                    child: Image.asset('images/klogo.png',),
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

