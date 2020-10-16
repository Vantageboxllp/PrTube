import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class HomeSlider1 extends StatefulWidget {
  const HomeSlider1({Key key}) : super(key: key);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider1> {
  static const length = 3;
  final pageIndexNotifier = ValueNotifier<int>(0);
  static List<String> imgList = [
    'images/pic1.png',
    'images/pic2.png',
    'images/pic3.png',
    'images/pic4.jpg',
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(
      children: <Widget>[
        Container(
          height: containerHeight * 0.30,
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.only(top: 20),
          child: PageView.builder(

            onPageChanged: (index) => pageIndexNotifier.value = index,
            
            itemCount: imgList.length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  SizedBox(
                    height: containerHeight * 0.30,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Card(
                        elevation: 5,
                        child: Image.asset(imgList[index],fit: BoxFit.fill,)
                    ),
                  ),


                ],
              );

            },
          ),

        ),
        Padding(
          padding: EdgeInsets.only(top:175,left: 100,right: 100),
          child: _buildExample1(),
        )

      ],

    );
  }

  PageViewIndicator _buildExample1() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: imgList.length,
      normalBuilder: (animationController, index) =>
          Circle(
            size: 8.0,
            color: Colors.blueGrey[900],
          ),
      highlightedBuilder: (animationController, index) =>
          ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.bounceIn,
            ),
            child: Circle(
              size: 12.0,
              color: Colors.white,
            ),
          ),
    );
  }
}
