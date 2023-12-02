import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WritingView extends StatefulWidget {
  const WritingView({super.key});

  @override
  State<WritingView> createState() => _WritingViewState();
}

class _WritingViewState extends State<WritingView> {
  DateTime? selectedDate;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {

      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '나의 발자취',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 1.0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black)),
      ),
      resizeToAvoidBottomInset : false,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPhotoArea(),

                Text(
                  '날짜',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now());
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    },
                    child: Text(
                        'selectedDate',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF5F5F5),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  '위치',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.0),
                TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true)),
                SizedBox(height: 30.0),
                Text(
                  '오늘의 일기',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: contentController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 80),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true),
                ),
                SizedBox(height: 20.0,),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '완료',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF8474F7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minimumSize: const Size.fromHeight(53)))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
      width: 100,
      height: 100,
      child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
    )
        : Container(
      width: 100,
      height: 100,
      child: IconButton(
        onPressed: (){
          getImage(ImageSource.camera);
        },
        icon: Icon(Icons.camera_alt),
        color: Color(0xFF8474F7),
        // size: 30,
      ),
    );
  }

}