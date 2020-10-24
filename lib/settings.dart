import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  createState() => SettingsState();
}

class SettingsState extends State<Settings>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text("Hello, Settings!"),
      ),
    );
  }
}