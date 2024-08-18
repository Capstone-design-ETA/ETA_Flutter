import 'package:eta_frontend/view/statistics/statistics_main_view.dart';
import 'package:flutter/material.dart';

class FeedsView extends StatefulWidget {
  const FeedsView({super.key});

  @override
  State<FeedsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends State<FeedsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pin_drop,
              color: Color(0xFF686868),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '제주시 - 애월',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        // centerTitle: true,
        elevation: 1.0,
        toolbarHeight: 61.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 16.0,
              color: Color(0xFF686868),
            ),
            Image.asset(
              'images/selfie.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2023/12/1',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '제주도 여행!! 넘 재밌었다 ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 16.0,
              color: Color(0xFF686868),
            ),
            Image.asset(
              'images/selfie2.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2023/12/1',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '제주도 여행2!!개꿀잼',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 16.0,
              color: Color(0xFF686868),
            ),
            Image.asset(
              'images/food1.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2023/11/25',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '맛있다!!',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color.fromRGBO(132, 116, 247, 100),
                  ),
                ],
              ),
            ),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedsView(),
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.edit_note,
                    color: Color.fromRGBO(132, 116, 247, 100),
                  ),
                ],
              ),
            ),
            label: '기록',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StaticMainView(),
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.analytics,
                    color: Color.fromRGBO(132, 116, 247, 100),
                  ),
                ],
              ),
            ),
            label: '통계',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              child: Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: Color.fromRGBO(132, 116, 247, 100),
                  ),
                ],
              ),
            ),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
