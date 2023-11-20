import 'package:flutter/material.dart';

class SignUp2View extends StatefulWidget {
  const SignUp2View({super.key});

  @override
  State<SignUp2View> createState() => _SignUp2ViewState();
}

class _SignUp2ViewState extends State<SignUp2View> {
  final _formKey = GlobalKey<FormState>();
  int userHeight = 0;
  int userWeight = 0;
  bool _isDisable = true;

  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
      setState(() {
        _isDisable = false;
      });
    }
    else{
      setState(() {
        _isDisable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          _tryValidation();
        },
        child: Container(
          color: Colors.white,
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
              Form(
                key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '키',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      TextFormField(
                        key: ValueKey(1),
                        validator: (value){
                          if(value!.isEmpty) {
                            return '키를 입력해주세요!';
                          }
                          return null;
                        },
                        onSaved: (value){
                          userHeight = int.parse(value!);
                        },
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
                      TextFormField(
                        key: ValueKey(2),
                        validator: (value){
                          if(value!.isEmpty) {
                            return '체중을 입력해주세요!';
                          }
                          return null;
                        },
                        onSaved: (value){
                          userWeight = int.parse(value!);
                        },
                        decoration:
                        InputDecoration(
                          suffixText: 'kg',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  )
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: _isDisable? null : () {
                        Navigator.pushNamed(context, '/sign-up3');
                      },
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