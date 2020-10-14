import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youtube_vimeo/flutter_youtube_vimeo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/all_model.dart';
class YouTube extends StatefulWidget {
  String ids;
  final int id;
  final String cat;
  final CatData catData;
//CatData catData;
//print("$catData")
  YouTube(this.id, this.cat, this.catData);
  @override
  _YouTubeState createState() => _YouTubeState();
}

class _YouTubeState extends State<YouTube> {


  @override
  Widget build(BuildContext context) {
    widget.ids = YoutubePlayer.convertUrlToId(widget.catData.videos[widget.id].url)
        .toString();
    final appbar=AppBar(title: Text("video page"),);
    double container_height=MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

    ));
    return MaterialApp(
      home: Scaffold(

          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:50),
                height: container_height,
                child: YouVimPlayer('youtube', widget.ids),

              )
            ],
          ),
        ),
    );

  }
}