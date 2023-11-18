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
            SizedBox(width: 10.0,),
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
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white)),
        ],
      ),
      body: Column(
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
                    '2023/07/22',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10.0,),
                Text(
                  '제주도 여행!! 넘 재밌었다 ',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

