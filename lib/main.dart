import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'db.dart';
import 'home.dart';
import 'settings.dart';
import 'addclient.dart';
import 'analytics.dart';

final dbHelper = DatabaseHelper.instance;
final shades = () async => await dbHelper.queryAllRows();

void main() {
  runApp(MyApp());
}

class NavObject {
  Widget screen;
  Icon navIcon;
  Text title;
  NavObject({this.screen, this.navIcon, this.title});
}

List<NavObject> navItems = [
  NavObject(
    screen: Home(),
    navIcon: Icon(Icons.home),
    title: Text('Home'),
  ),
  
  NavObject(
    screen: AddClient(),
    navIcon: Icon(Icons.contact_page),
    title: Text('AddClient'),
  ),

  NavObject(
    screen: Analytics(),
    navIcon: Icon(Icons.assessment),
    title: Text('Analytics'),
  ),

  NavObject(
    screen: Settings(),
    navIcon: Icon(Icons.settings),
    title: Text('Settings'),
  ),
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _screenNumber = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: navItems[_screenNumber].screen,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.lightBlue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,

          type: BottomNavigationBarType.fixed,
          items: navItems
              .map((navItem) => BottomNavigationBarItem(
                    icon: navItem.navIcon,
                    title: navItem.title,
                  ))
              .toList(),
          currentIndex: _screenNumber,
          onTap: (i) => setState(() {
            _screenNumber = i;
          }),
        ),
      ),
    );
  }
}
