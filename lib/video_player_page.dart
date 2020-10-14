import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pregnancy_tube/models/all_model.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class video_player extends StatefulWidget {

  final int id;
  final String cat;
 final CatData catData;
//CatData catData;
//print("$catData")
  video_player(this.id, this.cat, this.catData);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<video_player> {
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
        //_playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
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
    //final product=Provider.of<CatData>(context);
    //final product=Provider.of<CatData>(context);
    //var data=product.videos;
    //print("$data");
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
    );

    final appBar = AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: const Text(
        'Videos ',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
    double container_height = MediaQuery.of(context).size.height - appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      onEnterFullScreen: (){
        //_controller.fitHeight(500);
      },
      player: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        width: 100,

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
        },
        onEnded: (data) {
          setState(() {});
       widget.catData.watched=true;
          /* _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Next Video Started!');*/
        },
      ),
      builder: (context, player) => Scaffold(

        key: _scaffoldKey,
        backgroundColor: Colors.black,
        appBar: appBar,
        body: Column(
          children: <Widget>[
            Container(
              height: container_height * 0.5,
              child: ListView(
                children: [
                  player,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _text(_videoMetaData.title),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: container_height * 0.5,
                child: ListView.builder(
                  itemCount: widget.catData.videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    item_no = index + 1;
                    return Material(

                      color: Colors.white12,


                      child: InkWell(
                           splashColor: Colors.white12,
                        focusColor: Colors.greenAccent,

                        child: Card(

                          elevation: 5,
                          clipBehavior: Clip.hardEdge,
                          color: Colors.white30,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  Positioned(
                                      left: 5,
                                      top: 20,
                                      child: Text(
                                        "\#$item_no",
                                        style: GoogleFonts.robotoCondensed(
                                            color: Colors.lightBlueAccent,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Center(
                                      child: Text(

                                        widget.catData.videos[index].title,textAlign: TextAlign.center,
                                        style: GoogleFonts.robotoCondensed(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child:CachedNetworkImage(
                                              imageUrl:
                                                  "https://img.youtube.com/vi/" +
                                                      YoutubePlayer
                                                          .convertUrlToId(widget
                                                              .catData
                                                              .videos[index]
                                                              .url) +
                                                      "/mqdefault.jpg",
                                              fit: BoxFit.fill,
                                            ),


                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap:_isPlayerReady
                            ? () => _controller.load(YoutubePlayer.convertUrlToId(
                                widget.catData.videos[index].url))
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget get _space => const SizedBox(height: 10);
}
