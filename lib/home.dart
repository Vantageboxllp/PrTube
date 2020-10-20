import 'package:flutter/material.dart';
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
                                    ])
                                ),
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
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
            )
          ),
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
