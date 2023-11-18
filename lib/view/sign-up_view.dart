import 'package:flutter/material.dart';

enum Sex { female, male }

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  Sex? _sex = Sex.female;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 180.0, 40.0, 0.0),
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
            Text('성별'),
            Column(
              children: <Widget>[
                RadioListTile<Sex>(
                  title: const Text('여'),
                  value: Sex.female,
                  groupValue: _sex,
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
            )
          ],
        ),
      ),
    );
  }
}
