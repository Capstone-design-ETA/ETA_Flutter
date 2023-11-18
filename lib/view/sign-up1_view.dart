import 'package:flutter/material.dart';

enum Sex { female, male }

class SignUp1View extends StatefulWidget {
  const SignUp1View({super.key});

  @override
  State<SignUp1View> createState() => _SignUp1ViewState();
}

class _SignUp1ViewState extends State<SignUp1View> {
  Sex? _sex = Sex.female;

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
              '본인의 성별과 나이를\n알려주세요!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              '성별',
              style: TextStyle(fontSize: 16.0),
            ),
            Column(
              children: <Widget>[
                RadioListTile<Sex>(
                  title: const Text('여'),
                  value: Sex.female,
                  groupValue: _sex,
                  activeColor: Color(0xFF8474F7),
                  onChanged: (Sex? value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
                RadioListTile<Sex>(
                  title: const Text('남'),
                  value: Sex.male,
                  groupValue: _sex,
                  onChanged: (Sex? value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
              ],
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '다음으로',
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
