import 'package:flutter/material.dart';
import 'package:pregnancy_tube/home.dart';
import 'package:pregnancy_tube/models/all_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: Text('Pregnancy Tube!'),
            leading: Icon(Icons.menu),
          ),
          body: SingleChildScrollView(child: Home()),
        ),
      ),
    );
  }
}
