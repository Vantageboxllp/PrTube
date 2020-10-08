import 'package:flutter/material.dart';
import './models/all_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class Catwise_vid_list extends StatelessWidget {
final CatData catData;
String id;

Catwise_vid_list(this.catData);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: Text(catData.name,
          style: TextStyle(fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w900,
          ),
      
          ),
        ),

        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.width * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
       
   // shrinkWrap: true,
            itemCount: catData.videos.length,
            itemBuilder: (context, index) {
              id = YoutubePlayer.convertUrlToId(catData.videos[index].url).toString();
              return Container(
               // color: Colors.blue,
                //height: 100,
                width: 150,
               margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                
                  child: Image.network('https://img.youtube.com/vi/$id/mqdefault.jpg',
                  //fit: BoxFit.fill,
                  ),
                  
                  ));
            },
          ),
        )

      ],
    );
  }
}