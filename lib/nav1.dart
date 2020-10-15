import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import './models/all_model.dart';

class HomePage extends StatefulWidget {

  final int video_id;
  final  String cat_id;
   final CatData catData;

  HomePage(this.video_id, this.cat_id, this.catData);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  


  String videoURL = "https://www.youtube.com/watch?v=n8X9_MgEdCg";

  YoutubePlayerController _controller;

  @override
  void initState() {
    
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoURL)
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Youtube Player"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              YoutubePlayerBuilder(
                              player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
                builder: (context,player){
                  return Column(
                    children: [
                      player,
                    ],
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}