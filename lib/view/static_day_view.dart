
import 'package:flutter/material.dart';

class StaticDayView extends StatefulWidget {
  const StaticDayView({super.key});

  @override
  State<StaticDayView> createState() => _StaticDayViewState();
}

class _StaticDayViewState extends State<StaticDayView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
        ),
        body: Column(

        )
      ),
    );
  }
}
