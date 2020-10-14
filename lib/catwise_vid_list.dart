import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pregnancy_tube/video_page.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import './models/all_model.dart';

class Catwise_vid_list extends StatefulWidget {
  final CatData catData;

  Catwise_vid_list(this.catData);

  @override
  _Catwise_vid_listState createState() => _Catwise_vid_listState();
}

class _Catwise_vid_listState extends State<Catwise_vid_list> {
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0.0 ? 1.0 : .23);
  }

  String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      /**/
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: FittedBox(
            child: Text(
              widget.catData.name,
              softWrap: true,
              style: GoogleFonts.robotoCondensed(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.width * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            // shrinkWrap: true,
            itemCount: widget.catData.videos.length,
            itemBuilder: (context, index) {
              id =
                  YoutubePlayer.convertUrlToId(widget.catData.videos[index].url)
                      .toString();
              return Center(
                child: Material(
                  color: Colors.black,
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(1.0),
                    hoverColor: Colors.white60.withOpacity(1.0),
                    highlightColor: Colors.orangeAccent.withOpacity(1.0),

                    /*         async*/
                    /*   await Future.delayed(Duration(milliseconds: 500));*/
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 500));
                      var cat = widget.catData.id;
                      var vid = index;

                      // setState(() => opacityLevel = opacityLevel == 0 ? 1.0: 0.0);
                      //_changeOpacity();
                      Navigator.push(
                        context,
                        //MaterialPageRoute(builder: (context) => video_player(index,cat,widget.catData)),
                        MaterialPageRoute(
                            builder: (context) =>video_page(index, cat, widget.catData)),
                        //MaterialPageRoute(builder: (context) => YouTube(index,cat,widget.catData)),
                        /*   //MaterialPageRoute(builder: (context) => YoutubePlayerDemoApp(index,cat,widget.catData)),*/
                      );
                    },
                    child: Ink(
                      color: Colors.black,
                      child: Card(
                        elevation: 1,
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://img.youtube.com/vi/$id/mqdefault.jpg',
                          width: 160,
                          height: 200,
                          fit: BoxFit.fill,

                          //errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
