import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselHomaPageImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw MaterialApp(
      home: Scaffold(
        body: CarouselSlider(
          options: CarouselOptions(
            height: 100.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                image:
                    new AssetImage("assets/images/apartments/apartment1.jpg"),
              )),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                image:
                    new AssetImage("assets/images/apartments/apartment2.jpg"),
              )),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                image:
                    new AssetImage("assets/images/apartments/apartment3.jpg"),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
