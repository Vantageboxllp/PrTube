import 'package:flutter/material.dart';
import 'package:pregnancy_tube/home.dart';
import 'package:pregnancy_tube/models/all_model.dart';
import 'package:pregnancy_tube/providers/data_provider.dart';
import 'package:pregnancy_tube/video_player_page.dart';
import 'package:provider/provider.dart';
import 'package:pregnancy_tube/video_player_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    CatData product;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      /*routes: {
        video_player.routeName:(ctx)=>video_player()
      },*/
    );
  }
}
