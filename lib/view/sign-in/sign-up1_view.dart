import 'package:eta_frontend/controller/flow_controller.dart';
import 'package:eta_frontend/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

enum Sex { female, male }

class SignUp1View extends StatefulWidget {
  const SignUp1View({super.key});

  @override
  State<SignUp1View> createState() => _SignUp1ViewState();
}

class _SignUp1ViewState extends State<SignUp1View> {
  SignUpController signUpController = Get.put(SignUpController());
  FlowController flowController = Get.put(FlowController());

  Sex _sex = Sex.female;
  final _formKey = GlobalKey<FormState>();
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
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 110,
                    lineHeight: 7.0,
                    trailing: Text('1/3'),
                    percent: 0.10,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: Color(0xFFF5F5F5),
                    progressColor: Color(0xFF8474F7),
                  ),
                  SizedBox(height: 50.0,),
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
                          onChanged: (value) {
                            setState(() {
                              _sex = value!;
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
                          onChanged: (value) {
                            setState(() {
                              _sex = value!;
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
                        signUpController.setAge(int.parse(value!));
                      },
                      onChanged: (value){
                        _tryValidation();
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
                          onPressed: _isDisable? null : () async {
                            bool isRegistered = await signUpController.registerUser(
                              signUpController.sex.toString(),
                              signUpController.age!,
                            );
                            debugPrint(isRegistered.toString());
                            if (isRegistered) {
                              Get.snackbar("Success", "User Registered");
                              flowController.setFlow(2);
                            } else {
                              Get.snackbar("Error", "Please fill all the fields");
                            }
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
        ),
      ),
    );
  }
}
