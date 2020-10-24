import 'package:flutter/material.dart';

class AddClient extends StatefulWidget {
  @override
  createState() => AddClientState();
}

class AddClientState extends State<AddClient>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text("Hello, AddClient!"),
      ),
    );
  }
}