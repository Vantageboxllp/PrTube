import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pregnancy_tube/video_player_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import './models/all_model.dart';

class Catwise_vid_list extends StatefulWidget {
  final CatData catData;

  Catwise_vid_list(this.catData);

  @override
  _Catwise_vid_listState createState() => _Catwise_vid_listState();
}

class _Catwise_vid_listState extends State<Catwise_vid_list> {
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
              style:GoogleFonts.robotoCondensed(
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
              id = YoutubePlayer.convertUrlToId(widget.catData.videos[index].url)
                  .toString();
              return Center(
                child: GestureDetector(
                  onTap: (){
                    var cat=widget.catData.id;
                    var vid=index;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => video_player(index,cat,widget.catData)),
                    );
                    //$id

                  },
                  child: Card(
                    elevation: 1,
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: 'https://img.youtube.com/vi/$id/mqdefault.jpg',
                      width: 160,
                      height: 200,
                      fit: BoxFit.fill,
                      //placeholder: (context, url) => CircularProgressIndicator(),
                      //errorWidget: (context, url, error) => Icon(Icons.error),
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
