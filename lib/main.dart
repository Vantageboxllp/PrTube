import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter/services.dart';

 
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blueGrey[900], // navigation bar color
    statusBarColor: Colors.blueGrey[900], // status bar color
  ));
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy',
      theme: ThemeData.dark(),
      home: SafeArea(
              child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blueGrey[900],
            //backgroundColor: Color.fromRGBO(53,53,53,1),
            title: Center(child: Text('Best Pregnancy Video Tips!!')),
            //leading: Icon(Icons.menu),
          ),
          body: Home(),
        ),
      ),
    );
  }
}