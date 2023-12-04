import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../controller/flow_controller.dart';
import '../../controller/sign_up_controller.dart';

class SignUp2View extends StatefulWidget {
  const SignUp2View({super.key});

  @override
  State<SignUp2View> createState() => _SignUp2ViewState();
}

class _SignUp2ViewState extends State<SignUp2View> {
  final _formKey = GlobalKey<FormState>();
  bool _isDisable = true;

  SignUpController signUpController = Get.put(SignUpController());
  FlowController flowController = Get.put(FlowController());

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
                    trailing: Text('2/3'),
                    percent: 0.40,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: Color(0xFFF5F5F5),
                    progressColor: Color(0xFF8474F7),
                  ),
                  SizedBox(height: 50.0,),
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
                              signUpController.setHeight(int.parse(value!));
                            },
                            onChanged: (value){
                              _tryValidation();
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
                              signUpController.setWeight(int.parse(value!));
                            },
                            onChanged: (value){
                              _tryValidation();
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
                            flowController.setFlow(3);
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