import 'package:flutter/material.dart';

class WritingView extends StatefulWidget {
  const WritingView({super.key});

  @override
  State<WritingView> createState() => _WritingViewState();
}

class _WritingViewState extends State<WritingView> {
  DateTime? selectedDate;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Icon(
                Icons.camera_alt,
                color: Color(0xFF8474F7),
                size: 30,
              ),
            ),
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
                    'test',
                  style: TextStyle(
                    color: Colors.black87
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
            // TextField(
            //     onTap: () async {
            //       final pickedDate = await showDatePicker(
            //           context: context,
            //           initialDate: DateTime.now(),
            //           firstDate: DateTime(2001),
            //           lastDate: DateTime.now());
            //       setState(() {
            //         selectedDate = pickedDate;
            //       });
            //     },
            //     readOnly: true,
            //     decoration: InputDecoration(
            //         contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //           borderSide: BorderSide.none,
            //         ),
            //         filled: true)),
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
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
                        minimumSize: const Size.fromHeight(53))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
