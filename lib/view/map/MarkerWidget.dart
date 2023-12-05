import 'package:flutter/material.dart';

class ETA_marker extends StatelessWidget {
  const ETA_marker({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 15,
          child: Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/selfie2.png')
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 0,
                    blurRadius: 5.0,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              )),
        ),
        Positioned(
          left: 50,
          child: Container(
              child: Center(
                child: Text(
                  '1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Color(0xFF8474F7),
                borderRadius: BorderRadius.circular(10),
              )),
        ),
      ],
    );
  }
}
