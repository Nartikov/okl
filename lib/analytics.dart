import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  @override
  createState() => AnalyticsState();
}

class AnalyticsState extends State<Analytics>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text("Hello, AddClient!"),
      ),
    );
  }
}