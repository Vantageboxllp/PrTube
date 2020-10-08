import 'package:flutter/material.dart';
import 'package:pregnancy_tube/catwise_vid_list.dart';
import './models/all_model.dart';
import 'service_getdata.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

List<CatData> _catData;
bool _loading;

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
  }

  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          color: Colors.black,
         height: dh*0.9,

           child: ListView.builder(
             scrollDirection: Axis.vertical,
             itemCount: null == _catData ? 0 : _catData.length,
             itemBuilder:(context, index) {
               CatData catData = _catData[index];
              //return Text("data                             ");
               return Catwise_vid_list(catData);

             },
             )
        ),
      ],
    );
  }
}