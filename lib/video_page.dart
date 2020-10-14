import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pregnancy_tube/models/all_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class video_page extends StatefulWidget {
  final int id;
  final String cat;
  final CatData catData;

//CatData catData;
//print("$catData")
  video_page(this.id, this.cat, this.catData);

  @override
  _video_pageState createState() => _video_pageState();
}

class _video_pageState extends State<video_page> {
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
        YoutubePlayer.convertUrlToId(widget.catData.videos[widget.id].url)
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
      title: Text("Videos"),
      centerTitle: true,
      backgroundColor: Colors.black,
    );
    double container_height = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    double container_width = MediaQuery.of(context).size.width;

    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);

          //_controller.seekTo(_controller.value.position);

          //_controller.play();
        },
        onEnterFullScreen: () {
          //_isPlayerReady=true;

          SystemChrome.setPreferredOrientations(DeviceOrientation.values);

          //_controller.seekTo(_controller.value.position);
          //print(_controller.value.position);

          //_controller.play();

          // print("time${_seekToController.text}");
        },
        player: YoutubePlayer(
          controller: _controller,

          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          //width: 100,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
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
            //_controller.addListener(listener);
          },

          onEnded: (data) {
            setState(() {});
            /* _controller
                .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
            _showSnackBar('Next Video Started!');*/
          },
        ),
        builder: (ctx, player) => Scaffold(
              appBar: appbar,
              key: _scaffoldKey,
              backgroundColor: Colors.black,
              body: Column(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Container(
                        height: container_height * 0.5, child: player),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      //width: container_width,
                      height: container_height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Padding(
                            padding: const EdgeInsets.only(left:10.0,right: 10.0),
                            child: Text(_videoMetaData.title,style:GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.lightBlueAccent),softWrap: true,),
                          ))

                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Container(
                        height: container_height * 0.5,
                        child: ListView.builder(
                          itemCount: widget.catData.videos.length,
                          itemBuilder: (BuildContext context, int index) {
                            item_no = index + 1;
                            return Material(
                              color: Colors.black,
                              child: InkWell(
                                splashColor: Colors.white12,
                                focusColor: Colors.greenAccent,
                                child: Card(
                                  elevation: 5,
                                  clipBehavior: Clip.hardEdge,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          /* IconButton(
                                      icon: Icon(
                                        widget.catData.watched
                                            ? Icons.check_circle
                                            : null,
                                      ),
                                      color:
                                      Theme.of(context).accentColor,
                                      onPressed: () {
                                        widget.catData
                                            .togglefavoriteStatus();
                                      },
                                    ),*/
                                          CircleAvatar(

                                            child: Flexible(
                                                fit: FlexFit.tight,
                                                flex: 0,
                                                child: Text(
                                                  "\#$item_no",
                                                  style:
                                                      GoogleFonts.robotoCondensed(
                                                          color: Colors
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                )),
                                            backgroundColor: Colors.lightBlueAccent,

                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                widget.catData.videos[index]
                                                    .title,
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "https://img.youtube.com/vi/" +
                                                          YoutubePlayer
                                                              .convertUrlToId(
                                                                  widget
                                                                      .catData
                                                                      .videos[
                                                                          index]
                                                                      .url) +
                                                          "/mqdefault.jpg",
                                                  fit: BoxFit.fill,
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: _isPlayerReady
                                    ? () => _controller.load(
                                        YoutubePlayer.convertUrlToId(
                                            widget.catData.videos[index].url))
                                    : null,
                              ),
                            );
                          },
                        ),
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
