import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import './models/all_model.dart';
import 'video_page.dart';

class Catwise_vid_list extends StatefulWidget {
  final CatData catData;

  //final bool rating_flag;

  Catwise_vid_list(this.catData);

  @override
  _Catwise_vid_listState createState() => _Catwise_vid_listState();
}

class _Catwise_vid_listState extends State<Catwise_vid_list> {
  String id;
  bool isSelected = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //RatingMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            widget.catData.name,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 0, 8, 14),
          color: Colors.transparent,
          height: MediaQuery.of(context).size.width * 0.24,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            // shrinkWrap: true,
            itemCount: widget.catData.videos.length,
            itemBuilder: (context, index) {
              id =
                  YoutubePlayer.convertUrlToId(widget.catData.videos[index].url)
                      .toString();
              return FittedBox(
                fit: BoxFit.cover,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        //color: Colors.blue,
                        //height: 100,
                        // width: 200,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: new AnimatedOpacity(
                            opacity: 1,
                            duration: Duration(milliseconds: 200),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://img.youtube.com/vi/$id/mqdefault.jpg',
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: Colors.grey[900],
                                  ),
                                  fit: BoxFit.fill,
                                  //  width: 8,
                                ),
                                Positioned.fill(
                                    child: Material(

                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.black,
                                    onTap: () {

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => video_page(
                                                index,
                                                widget.catData.id,
                                                widget.catData)),
                                      );
                                      //print(r.toString());
                                      //                 var cat=catData.id;
                                      // var vid=index;
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => video_player(index,cat,catData)),
                                      // );
                                    },
                                  ),
                                ))
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

}
