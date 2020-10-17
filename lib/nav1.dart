import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:pregnancy_tube/models/slider_model.dart';

class HomeSlider1 extends StatefulWidget {
  final List<SliderModel> _slidermodel;

  HomeSlider1(this._slidermodel);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider1> {
  SliderModel slider;

  int l;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //static const length = 3;
  final pageIndexNotifier = ValueNotifier<int>(1);
  static List<String> imgList = [
    'images/pic1.png',
    'images/pic2.png',
    'images/pic3.png',
    'images/pic4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height;
double container_width= MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          height: containerHeight * 0.30,
          width: container_width,
          padding: EdgeInsets.only(top: 20),
          child: PageView.builder(
            onPageChanged: (index) => pageIndexNotifier.value = index,
            itemCount: widget._slidermodel.length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  SizedBox(
                    height: containerHeight * 0.30,
                    width: container_width,
                    child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            print(index);
                          },
                          child: CachedNetworkImage(
                            imageUrl:
                            widget._slidermodel[index].imageUrl,
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 175, left: 100, right: 100),
          child: _buildExample1(),
        )
      ],
    );
  }

  PageViewIndicator _buildExample1() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: widget._slidermodel.length,
      //indicatorPadding: EdgeInsets.all(2),
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.blueGrey[900],
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.bounceInOut,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
