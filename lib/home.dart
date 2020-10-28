import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import './models/all_model.dart';
import './models/slider_model.dart';
import 'catwise_vid_list.dart';
import 'service_getdata.dart';
import 'widget_home_slider.dart';

class Home extends StatefulWidget {
  SharedPreferences pref;

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ratingController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  bool _rated;
  bool rating_flag;

  List<CatData> _catData;
  List<SliderModel> _slidermodel;
  bool _loading;
  String _name;

  SharedPreferences pref;
  bool video_page_visited;
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0, // Show rate popup on first day of install.
    minLaunches: 1,

  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loading = true;

    Services.getData().then((catData) {
      setState(() {
        _catData = catData;
        _loading = false;
      });
    });
    Services.get_sliderimages().then((sliderimage) {
      setState(() {
        _slidermodel = sliderimage;
      });
    });

    Future.delayed(Duration.zero, () async {
      getsharedPreferance();
      RatingMethod();
    });

  }

  @override
  Widget build(BuildContext context) {
    //clear_pref();
    double dh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //  HomeSlider(),
                FutureBuilder(
                  future: Services.get_sliderimages(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data != null) {
                      return HomeSlider1(snapshot.data, _catData);
                    }
                    return Container();
                  },
                  // child: HomeSlider1(_slidermodel)
                )
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              CatData catData = _catData[index];

              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blueGrey[700],
                            Colors.blueGrey[900],
                          ])),
                  child: Catwise_vid_list(catData));
            },
            childCount: null == _catData ? 0 : _catData.length,
          )),
        ]),
        Container(
          //color: Color.fromRGBO(53,53,53,.9),
          width: double.infinity,
          padding: EdgeInsets.all(6),
          child: Text(""),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blueGrey[900],
            Colors.blueGrey[900].withOpacity(.2),
            //Color.fromRGBO(53,53,53,1),
            //Color.fromRGBO(53,53,53,.4),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
      ],
    );
  }

  clear_pref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> RatingMethod() {
    //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    //Future<SharedPreferences> pref = SharedPreferences.getInstance();

    rateMyApp.init().then((_) {
      rateMyApp.conditions[1]
          .readFromPreferences(pref, rateMyApp.preferencesPrefix);

      print(pref.getInt("rateMyApp_launches") ?? 0);
      int launches = pref.getInt("rateMyApp_launches") ?? 0;
      bool doNotOpenAgain = pref.getBool("rateMyApp_doNotOpenAgain") ?? false;
      video_page_visited = pref.getBool(("video_page_visited"));

      if (doNotOpenAgain == false && launches >=2) {
        // Or if you prefer to show a star rating bar :

        rateMyApp.showStarRateDialog(
          context,
          title: 'Do a Favour by Rating us',
          // The dialog title.,

          message:
              'Babies are little angles and This app is our angle Please help us Give a 5 star rating in play store..',

          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.

          actionsBuilder: (context, stars) {
            // Triggered when the user updates the star rating.
            String appPackageName = "com.momsdoctor.pregnancy_tube";
            if (stars >= 4) {
              try {
                // launch("market://details?id=" + appPackageName);
              } on PlatformException catch (e) {
                launch("https://play.google.com/store/apps/details?id=" +
                    appPackageName);
                rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                Navigator.pop<RateMyAppDialogButton>(
                    context, RateMyAppDialogButton.rate);
              } finally {
                launch("https://play.google.com/store/apps/details?id=" +
                    appPackageName);
                rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                Navigator.pop<RateMyAppDialogButton>(
                    context, RateMyAppDialogButton.rate);
              }
            }
            return [
              // Return a list of actions (that will be shown at the bottom of the dialog).

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  stars > 0 && stars < 4
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .10,
                          child: TextField(
                              controller: ratingController,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                hintText: '',
                                labelText: 'Let us know, what went wrong',
                                labelStyle: TextStyle(
                                    color: Colors.cyan.withOpacity(.5),
                                    fontWeight: FontWeight.bold),
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
                        )
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () async {
                            if (stars < 4) {
                              if (ratingController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "type your comments",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.lightBlue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                enterToFirebase();
                                Fluttertoast.showToast(
                                    msg: "Thanks your comments",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.lightBlue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                                await rateMyApp.callEvent(
                                    RateMyAppEventType.rateButtonPressed);
                                Navigator.pop<RateMyAppDialogButton>(
                                    context, RateMyAppDialogButton.rate);
                              }
                            }
                            // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                            // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                          },
                        ),
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ];
          },
          ignoreNativeDialog: Platform.isAndroid,
          // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          dialogStyle: DialogStyle(
            // Custom dialog styles.
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20),
          ),
          starRatingOptions: StarRatingOptions(),
          // Custom star bar rating options.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
        );
      }
    });
  }

  getsharedPreferance() async {
    pref = await SharedPreferences.getInstance();
    pref.setBool('video_page_visited', false);
  }

  void enterToFirebase() {
    databaseReference
        .child("comments")
        .push()
        .set({"comment": ratingController.text}).asStream();
  }
}
