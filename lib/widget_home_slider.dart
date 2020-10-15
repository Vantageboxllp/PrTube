
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 26, 0, 20),
      child: SizedBox(
  
  height: MediaQuery.of(context).size.height * 0.25,
  width: double.infinity, 
  child: InkWell(
    onTap: (){},
      child: Carousel(
      
        overlayShadowColors: Colors.blueGrey[900],
        boxFit: BoxFit.fill,
        images: [
          NetworkImage('https://covalentcareers3.s3-accelerate.amazonaws.com/media/images/Slider_SafeExersize.max-800x550.png'),
          NetworkImage('https://i.ytimg.com/vi/zCOTP67npkg/maxresdefault.jpg'),
          NetworkImage('https://www.drbarkha.com/wp-content/uploads/2017/05/banner2.jpg'),
          
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.lightGreenAccent,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        borderRadius: false,
    ),
  )
),
    );
  }
}