import 'package:flutter/material.dart';

class SignUp2View extends StatefulWidget {
  const SignUp2View({super.key});

  @override
  State<SignUp2View> createState() => _SignUp2ViewState();
}

class _SignUp2ViewState extends State<SignUp2View> {
  TextEditingController _height_controller = TextEditingController();
  TextEditingController _weight_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(40.0, 180.0, 40.0, 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '나이와 키,\n체중을 알려주세요!',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                '키',
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                controller: _height_controller,
                decoration:
                InputDecoration(
                  suffixText: 'cm',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '체중',
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                controller: _weight_controller,
                decoration:
                InputDecoration(
                  suffixText: 'kg',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: TextInputType.number,
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
      ),
    );
  }
}