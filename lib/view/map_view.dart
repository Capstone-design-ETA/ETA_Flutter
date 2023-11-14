import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'ETA',
          style: TextStyle(color: Color(0xFF5846F5)),
        ),
        centerTitle: true,
        elevation: 1.0,
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.menu, color: Color(0xFF9E9E9E))),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: Color(0xFF9E9E9E))),
        ],
      ),
      body: Container(color: Colors.black12),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/writing');
          },
          child: Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: Color(0xFF8474F7)),
    );
  }
}

// 사진과 일기 개수 배지
// Stack(children: [
// Positioned(
// top: 15,
// child: Container(
// width: 70.0,
// height: 70.0,
// decoration: BoxDecoration(
// color: Color(0xFF9E9E9E),
// borderRadius: BorderRadius.circular(20),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.9),
// spreadRadius: 0,
// blurRadius: 5.0,
// offset: Offset(0, 5), // changes position of shadow
// ),
// ],
// )),
// ),
// Positioned(
// left: 50,
// child: Container(
// child: Center(
// child: Text(
// '1',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// fontSize: 20,
// fontWeight: FontWeight.w800,
// ),
// ),
// ),
// width: 30.0,
// height: 30.0,
// decoration: BoxDecoration(
// color: Color(0xFF8474F7),
// borderRadius: BorderRadius.circular(10),
// )),
// ),
// ])
