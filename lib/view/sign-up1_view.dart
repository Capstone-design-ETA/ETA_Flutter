import 'package:flutter/material.dart';

enum Sex { female, male }

class SignUp1View extends StatefulWidget {
  const SignUp1View({super.key});

  @override
  State<SignUp1View> createState() => _SignUp1ViewState();
}

class _SignUp1ViewState extends State<SignUp1View> {
  Sex? _sex = Sex.female;
  final _formKey = GlobalKey<FormState>();
  int userAge = 0;
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
                  ListTile(
                    title: const Text('여'),
                    leading: Radio<Sex>(
                      value: Sex.female,
                      groupValue: _sex,
                      activeColor: Color(0xFF8474F7),
                      onChanged: (Sex? value) {
                        setState(() {
                          _sex = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('남'),
                    leading: Radio<Sex>(
                      value: Sex.male,
                      groupValue: _sex,
                      activeColor: Color(0xFF8474F7),
                      onChanged: (Sex? value) {
                        setState(() {
                          _sex = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '나이',
                style: TextStyle(fontSize: 16.0),
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty) {
                      return '나이를 입력해주세요!';
                    }
                    return null;
                  },
                  onSaved: (value){
                    userAge = int.parse(value!);
                  },
                  decoration:
                  InputDecoration(
                    suffixText: '세',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: _isDisable? null : () {
                        Navigator.pushNamed(context, '/sign-up2');
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
