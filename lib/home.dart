import 'package:flutter/material.dart';
import 'Client.dart';
import 'main.dart';
import 'db.dart';

class Home extends StatefulWidget {
  @override
  createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Client> tempclilist;

  Future<void> addClient() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnFamile: 'Nartikov',
      DatabaseHelper.columnName: 'Alex',
      DatabaseHelper.columnPhone: '79054888886',
      DatabaseHelper.columnLl: '-43.15 fg',
      DatabaseHelper.columnRl: '-46.25 fdh'
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  Future<List<Client>> getClients() async {
    final List<Map<String, dynamic>> clients = await dbHelper.queryAllRows();
    return List.generate(
        clients.length,
        (index) => Client(
            id: clients[index]['id'],
            famile: clients[index]['famile'],
            name: clients[index]['name'],
            phone: clients[index]['phone'],
            ll: clients[index]['ll'],
            rl: clients[index]['rl']));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        height: 400.0,
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 5.0)
            ]),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () async {
                      tempclilist = await getClients();
                      tempclilist[0].display();
                      
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.hail),
                    onPressed: () => addClient(),
                  ),
                  Text('Нартиков Александр',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Text(
                    'Клиент с: 15.11.2020',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star_half,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 2.0,
                    children: <Widget>[
                      Chip(label: Text('Левая 356LLdh dhf45')),
                      Chip(label: Text('Правая 356LLdh dhf45')),
                    ],
                  ),
                  Text(
                    'телефон: +79054888886',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }
}
