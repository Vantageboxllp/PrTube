import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingDialog extends StatefulWidget {
  int _stars = 0;
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {


  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
        color: widget._stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
         widget. _stars = starCount;
         if(widget._stars==4){
           String appPackageName="com.momsdoctor.pregnancy_tube";
          // StoreRedirect.redirect(androidAppId: "com.example.pregnancy_tube");
           try {

            // launch("market://details?id=" + appPackageName);
           } on PlatformException catch(e) {
             launch("https://play.google.com/store/apps/details?id=" + appPackageName);
           } finally {
             launch("https://play.google.com/store/apps/details?id=" + appPackageName);
           }
         }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      title: Center(child: Text('Rate this post'),),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStar(1),
          _buildStar(2),
          _buildStar(3),
          _buildStar(4),
          _buildStar(5),
        ],
      ),
      actions: <Widget>[

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            widget._stars==2 ?Container(
              width: MediaQuery.of(context).size.width,
              height: 100,

              child: TextField(


                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)
                  ),
                  hintText: 'Type Your Review',

                  labelText: 'Comment',
                )
              ),
            ):Container(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: Navigator.of(context).pop,
                ),

            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(widget._stars);
              },
            ),
              ],
            ),
          ],
        )



      ],
    );
  }

}