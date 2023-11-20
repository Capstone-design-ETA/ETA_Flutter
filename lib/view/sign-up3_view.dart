import 'package:flutter/material.dart';

class SignUp3View extends StatefulWidget {
  const SignUp3View({super.key});

  @override
  State<SignUp3View> createState() => _SignUp3ViewState();
}

class _SignUp3ViewState extends State<SignUp3View> {

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
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 180.0, 40.0, 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '자신에게 적당한\n하루 걷기 목표를 선택해주세요!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 500,
              // color: Colors.orange,
              child: ListView.builder(
                itemCount: levelList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
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
                      Navigator.pushNamed(context, '/map');
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
    );
  }
}