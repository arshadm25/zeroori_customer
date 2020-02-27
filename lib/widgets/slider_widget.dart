import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/models/slider.dart' as prefix;

class SliderWidget extends StatelessWidget{
  final List<prefix.Slider> sliders;

  const SliderWidget({Key key, this.sliders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      autoPlay: true,
      viewportFraction: 1.0,
      height: MediaQuery.of(context).size.height/4,
      items: sliders.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.amber
                ),
                child: Image.asset(slider.image,fit: BoxFit.cover,)
            );
          },
        );
      }).toList(),
    );
  }
}