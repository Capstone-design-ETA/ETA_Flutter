import 'package:eta_frontend/view/sign-up1_view.dart';
import 'package:eta_frontend/view/sign-up2_view.dart';
import 'package:eta_frontend/view/sign-up3_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/flow_controller.dart';


class SignupBodyView extends StatefulWidget {
  const SignupBodyView({super.key});

  @override
  State<SignupBodyView> createState() => _SignupBodyViewState();
}

class _SignupBodyViewState extends State<SignupBodyView> {
  FlowController flowController = Get.put(FlowController());
  late int _currentFlow;

  @override
  void initState() {
    _currentFlow = FlowController().currentFlow;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: GetBuilder<FlowController>(
          builder: (context) {
            // Menampilkan tampilan sesuai dengan alur saat ini
            if (flowController.currentFlow == 1) {
              return const SignUp1View();
            } else if (flowController.currentFlow == 2) {
              return const SignUp2View();
            } else {
              return const SignUp3View();
            }
          },
        ),
      ),
    );
  }
}