import 'package:eta_frontend/controller/flow_controller.dart';
import 'package:eta_frontend/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SignUp3View extends StatefulWidget {
  const SignUp3View({super.key});

  @override
  State<SignUp3View> createState() => _SignUp3ViewState();
}

class _SignUp3ViewState extends State<SignUp3View> {
  SignUpController signUpController =
  Get.put(SignUpController(), permanent: false);
  FlowController flowController = Get.put(FlowController());

  var levelList = [
    '적게 걸을래요',
    '적당히 걸을래요',
    '많이 걸을래요'
  ];
  int _selectedLevel = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 110,
                lineHeight: 7.0,
                trailing: Text('3/3'),
                percent: 0.70,
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Color(0xFFF5F5F5),
                progressColor: Color(0xFF8474F7),
              ),
              SizedBox(height: 50.0,),
              Text(
                '자신에게 적당한\n하루 걷기 목표를 선택해주세요!',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                height: 300,
                // color: Colors.orange,
                child: ListView.builder(
                  itemCount: levelList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListTile(
                        title: Text(levelList[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        selected: index == _selectedLevel,
                        selectedTileColor: Color(0xFF8474F7),
                        selectedColor: Colors.white,
                        onTap: () {
                          setState(() {
                            _selectedLevel = index;
                            signUpController.setLevel(index);
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(56.0),
                          side: BorderSide(width: 3, color: Color(0xFF8474F7))
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        signUpController.postSignUpDetails();
                      },
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
      ),
    );
  }
}