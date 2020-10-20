import 'package:flutter/material.dart';
import 'package:pregnancy_tube/models/slider_model.dart';
import 'package:pregnancy_tube/service_getdata.dart';

import './models/all_model.dart';
import 'catwise_vid_list.dart';
import 'nav1.dart';
import 'service_getdata.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CatData> _catData;
  List<SliderModel> _slidermodel;
  bool _loading;
  //CatData catData;
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

    Services.get_sliderimages("slider_images.json").then((sliderimage) {
      setState(() {
        _slidermodel = sliderimage;
      });
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
                FutureBuilder(
                  future: Services.get_sliderimages("slider_images.json"),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
                        return HomeSlider1(snapshot.data,_catData);
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
  }
}
