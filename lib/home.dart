import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'catwise_vid_list.dart';
import './models/all_model.dart';
import 'service_getdata.dart';
import './models/slider_model.dart';
import 'widget_home_slider.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CatData> _catData;
  List<SliderModel> _slidermodel;
  bool _loading;

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 2,
    remindDays: 1,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.momsdoctor.pregnancy_tube',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    print('init state in home');

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

    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        print(rateMyApp.shouldOpenDialog);
        rateMyApp.showStarRateDialog(
          context,
          title: 'Do us a favour ( Just 2 min )', // The dialog title.
          message:
              'Just like your baby, this app also needs your love and support......  Please consider rating our app on playstore! ', // The dialog message.
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          actionsBuilder: (context, stars) {
            // Triggered when the user updates the star rating.

            return [
              // Return a list of actions (that will be shown at the bottom of the dialog).
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  print('Thanks for the ' +
                      (stars == null ? '0' : stars.round().toString()) +
                      ' star(s) !');
                  // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                  // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                  await rateMyApp
                      .callEvent(RateMyAppEventType.rateButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(
                      context, RateMyAppDialogButton.rate);
                  if (stars >= 3) {
                    LaunchReview.launch(
                        androidAppId:"com.momsdoctor.pregnancy_tube");
                  }
                },
              ),
            ];
          },
          //  ignoreNativeDialog: Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          dialogStyle: DialogStyle(
            // Custom dialog styles.
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20),
          ),
          starRatingOptions:
              StarRatingOptions(), // Custom star bar rating options.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      //                             border: Border.all(
                      //   //color: Colors.blueGrey[800],
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blueGrey[700],
                            Colors.blueGrey[900],
                          ])),
                  // color: Colors.blueGrey[900],
                  // color: Color.fromRGBO(17, 23, 30, 1),
                  //height: dh*0.9,

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
    // return SingleChildScrollView(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [

    //       HomeSlider(),
    //       Container(child: Text("data"),),
    //       Container(

    //         color: Colors.black,
    //        height: dh*0.9,

    //          child: ListView.builder(

    //           physics: NeverScrollableScrollPhysics(),
    //           // scrollDirection: Axis.vertical,
    //           shrinkWrap: true,
    //            itemCount: null == _catData ? 0 : _catData.length,
    //            itemBuilder:(context, index) {
    //              CatData catData = _catData[index];
    //             //return Text("data                             ");
    //              return Catwise_vid_list(catData);

    //            },
    //            )
    //       ),
    //     ],
    //   ),
    // );
  }
}
