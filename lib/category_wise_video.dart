import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/all_model.dart';
class category_wise_video extends StatefulWidget {

  final int id;
  static String cat;
  //final CatData catData;
  final List<CatData> catdatas;
  //int category_id= int.parse(cat);

//CatData catData;
//print("$catData")
  category_wise_video(this.id, this.catdatas);
  @override
  _category_wise_videoState createState() => _category_wise_videoState();
}

class _category_wise_videoState extends State<category_wise_video> {
  bool end_time = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  int item_no;

  @override
  void initState() {
    super.initState();
    String ids =
    YoutubePlayer.convertUrlToId(widget.catdatas[widget.id].videos[0].url)
        .toString();
    _controller = YoutubePlayerController(
      initialVideoId: ids,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        //controlsVisibleAtStart:true ,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,

        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
    /*else if(_controller.value.isFullScreen){
      //_controller.play();

    }*/
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text(widget.catdatas[widget.id].name),
      centerTitle: true,
      backgroundColor: Colors.blueGrey[900],
    );
    double container_height = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    double container_width = MediaQuery.of(context).size.width;

    return YoutubePlayerBuilder(
        onExitFullScreen: () {

          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          Future.delayed(const Duration(seconds: 1), () {
            _controller.play();
          });
          Future.delayed(const Duration(seconds: 5), () {
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          });


        },
        onEnterFullScreen: () {
          //_isPlayerReady=true;

          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          //_controller.play();
        },
        player: YoutubePlayer(
          controller: _controller,
          width: container_width,
          aspectRatio: 21/9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          //width: 100,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                //log('Settings Tapped!');
              },
            ),
          ],
          onReady: () {
            _isPlayerReady = true;

          },

          onEnded: (data) {
            setState(() {});

          },

        ),
        builder: (ctx, player) => Scaffold(
          appBar: appbar,
          key: _scaffoldKey,
          backgroundColor: Colors.blueGrey[900],
          body: Column(
            children: <Widget>[

              Container(

                  child: player),
              Container(
                margin: EdgeInsets.fromLTRB(4, 10, 4, 10),
                color: Colors.blueGrey[900],

                child: Text(
                  _videoMetaData.title,
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                  softWrap: true,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  //color: Colors.red,
                  height: container_height * 0.55,
                  child: ListView.builder(
                    itemCount: widget.catdatas[widget.id].videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      item_no = index + 1;
                      return Material(
                        color: Colors.blueGrey[900],
                        child: InkWell(
                          splashColor: Colors.white12,
                          focusColor: Colors.greenAccent,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.blueGrey,
                                      Colors.blueGrey[900],
                                    ])),
                            // color: Colors.amber,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 40,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        "https://img.youtube.com/vi/" +
                                            YoutubePlayer
                                                .convertUrlToId(widget
                                                .catdatas[widget.id]
                                                .videos[index]
                                                .url) +
                                            "/mqdefault.jpg",
                                        fit: BoxFit.fill,
                                        width: 150,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0.0, 0.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                2, 20, 0, 0),
                                            child: Text(
                                              widget.catdatas[widget.id].videos[index].title
                                                  ,
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: _isPlayerReady
                              ? () => _controller.load(
                              YoutubePlayer.convertUrlToId(
                                  widget.catdatas[widget.id].videos[index].url))
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _text(String value) {
    return RichText(
      text: TextSpan(
        // text: '$title : ',
        style: Theme.of(context).textTheme.title,
        children: [
          TextSpan(
            text: value ?? '',
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
