import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingDialog extends StatefulWidget {
  int _stars = 0;



  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final myController = TextEditingController();
  bool _validate = false;

  final databaseReference = FirebaseDatabase.instance.reference();

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        size: 30.0,
        color: widget._stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          widget._stars = starCount;
          if (widget._stars >= 4) {
            final ProgressDialog pr = ProgressDialog(context);
            pr.style(
                message: 'Rate me on play store',
                borderRadius: 10.0,
                backgroundColor: Colors.white,
                progressWidget: CircularProgressIndicator(),
                elevation: 10.0,
                insetAnimCurve: Curves.easeInOutCirc,
                progressTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400),
                messageTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600));
            pr.show();
            String appPackageName = "com.momsdoctor.pregnancy_tube";
            // StoreRedirect.redirect(androidAppId: "com.example.pregnancy_tube");
            Future.delayed(const Duration(seconds: 3), () {
              pr.hide();
              try {
                // launch("market://details?id=" + appPackageName);
              } on PlatformException catch (e) {


                launch("https://play.google.com/store/apps/details?id=" +
                    appPackageName);
                Navigator.of(context).pop(false);
              } finally {
                launch("https://play.google.com/store/apps/details?id=" +
                    appPackageName);
                prefs.setBool("user_r2", true);
                Navigator.of(context).pop(false);
              }
            });
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double dp_height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double dp_width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: dp_height * .56,
          width: dp_width,

          child: AlertDialog(
            backgroundColor: Colors.white,

            titleTextStyle: GoogleFonts.robotoCondensed(
                color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),
            scrollable: false,
            clipBehavior: Clip.hardEdge,
            elevation: 5,
            title: Center(
              child: Text('Do a Favour by Rating us'),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: FittedBox(

                        child: Text(

                          "Babies are little angles and \nThis app is our angle \nPlease help us \nGive a 5 star rating in play store..",
                          style: TextStyle(color: Colors.blue,fontSize: 1,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildStar(1),
                    _buildStar(2),
                    _buildStar(3),
                    _buildStar(4),
                    _buildStar(5),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget._stars > 0 && widget._stars < 4
                      ? Visibility(
                         visible: true,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                           // height: 80,

                            child: TextField(
                                controller: myController,
                                style: TextStyle(color: Colors.pinkAccent),
                                decoration: new InputDecoration(
                                  //filled: true,
                                  fillColor: Colors.white60,
                                  hintStyle: TextStyle(
                                      color: Colors.cyan,
                                      fontWeight: FontWeight.bold),

                                  enabled: true,
                                  border: new OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.blue)),
                                  hintText: '',
                                  labelText: 'Let us know, what went wrong',
                                  labelStyle: TextStyle(
                                      color: Colors.cyan.withOpacity(.5),
                                      fontWeight: FontWeight.bold),
                                  errorText:
                                      _validate ? 'Value Can\'t Be Empty' : null,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide:
                                          new BorderSide(color: Colors.blue)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide:
                                          new BorderSide(color: Colors.red)),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blueGrey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.cyanAccent),
                                  ),
                                )),
                          ),
                      )
                      : Container(),
                  Container(
                    width: dp_width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FlatButton(
                          child: Text('CANCEL',
                              style: TextStyle(color: Colors.blue)),
                          onPressed: ()=>Navigator.of(context).pop(false)
                        ),
                        FlatButton(
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () async {
                            if (widget._stars != null) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              //bool _rated;
                              bool rated;
                              setState(() {
                                rated = true;
                              });
                              prefs.setBool("user_r2", true);

                              createRecord();
                              /*   if(myController.text.isEmpty) {

                             }
                             else{
                               Fluttertoast.showToast(
                                   msg: "Thanks your valuable comment",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.lightBlue,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             }*/

                              //Navigator.of(context, rootNavigator: true).pop(rated);
                              if(widget._stars<4)
                                {
                                  if (myController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "type your comments",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.lightBlue,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {


                                      Navigator.of(context).pop(rated);


                                  }
                                }


                              //Navigator.pop(context, true);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please Rate Me",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.lightBlue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void createRecord() {
    databaseReference
        .child("comments")
        .push()
        .set({"comment": myController.text}).asStream();


  }
  /*Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setBool('user_r2',false);
    //clear_pref();
    _rated = (prefs.getBool('user_r2') ?? false);

    int counter = (prefs.getInt('rating5') ?? 0);

    if (prefs.getInt('rating5') ==1) {
      setState(() {
        _rated = true;
        return _rated;
      });
      prefs.setBool("rated_flag", _rated);
      print(prefs.getInt("rating5"));
    } else if (counter < 3) {
      setState(() {
        counter = counter + 1;
        _rated = false;
        return counter;
      });
      //prefs.setBool("user_r2", _rated);
      prefs.setInt("rating5", counter);
      ////widget.pref.setBool("rated2",  _rated);
      print(prefs.getInt("rating5"));
    }
  }*/

}
