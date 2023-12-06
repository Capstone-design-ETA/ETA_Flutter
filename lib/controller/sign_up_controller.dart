import 'package:eta_frontend/view/map/map_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();


  String? _sex;
  String? get sex => _sex;
  void setSex(String? text) {
    _sex = text;
    debugPrint("Updated sex: $sex");
    update();
  }

  int? _age;
  int? get age => _age;
  void setAge(int? num) {
    _age = num;
    debugPrint("Updated age: $age");
    update();
  }

  int? _height;
  int? get height => _height;
  void setHeight(int? num) {
    _height = num;
    debugPrint("Updated height: $height");
    update();
  }

  int? _weight;
  int? get weight => _weight;
  void setWeight(int? num) {
    _weight = num;
    debugPrint("Updated Weight: $weight");
    update();
  }

  int? _level;
  int? get level => _level;
  void setLevel(int? num) {
    _level = num;
    debugPrint("Updated level: $level");
    update();
  }

  Future<bool> registerUser(String sex, int age) async {
    return true;
  }

  Future postSignUpDetails() async {
//     String newDocId =
//         FirebaseAuth.instance.currentUser?.uid ?? ''; // ID dokumen yang baru
//
// // Membuat dokumen baru dengan ID baru
//     DocumentReference newDocRef =
//     FirebaseFirestore.instance.collection('user').doc(newDocId);
//
//     await newDocRef.set({
//       'docId': newDocId,
//       'uid': FirebaseAuth.instance.currentUser!.uid,
//       'sex': sex,
//       'age': age,
//       'height': height,
//       'weight': weight,
//       'level': level,
//     });

    await Get.offAll(MapView());
  }


}