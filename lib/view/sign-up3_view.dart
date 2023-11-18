import 'package:flutter/material.dart';

class SignUp3View extends StatefulWidget {
  const SignUp3View({super.key});

  @override
  State<SignUp3View> createState() => _SignUp3ViewState();
}

class _SignUp3ViewState extends State<SignUp3View> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 180.0, 40.0, 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '자신에게 적당한\n하루 걷기 목표를 선택해주세요!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: (){},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          '적게 걸을래요',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                        ),
                      ),
                    ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 30.0),
                    primary: Color(0xFFF6F6F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56.0),
                    ),
                    minimumSize: Size.fromHeight(52),
                    elevation: 0.0,
                    side: BorderSide(width: 1.5, color: Color(0xFF8474F7))
                  ),
                ),
                SizedBox(height: 30.0,),
                ElevatedButton(
                  onPressed: (){},
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '적당히 걸을래요',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30.0),
                      primary: Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(56.0),
                      ),
                      minimumSize: Size.fromHeight(52),
                      elevation: 0.0,
                      side: BorderSide(width: 1.5, color: Color(0xFF8474F7))
                  ),
                ),
                SizedBox(height: 30.0,),
                ElevatedButton(
                  onPressed: (){},
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '많이 걸을래요',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30.0),
                      primary: Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(56.0),
                      ),
                      minimumSize: Size.fromHeight(52),
                      elevation: 0.0,
                      side: BorderSide(width: 1.5, color: Color(0xFF8474F7))
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '이제 시작해볼까요?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF8474F7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minimumSize: const Size.fromHeight(53))),
              ),
            )
          ],
        ),
      ),
    );
  }
}