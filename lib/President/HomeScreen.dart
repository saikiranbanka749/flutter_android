import 'package:allow_me/Login.dart';
import 'package:allow_me/widgets/CarouselHomaPageImages.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.keyboard_backspace_rounded),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              title: Text('Home'),
            ),
            body: Container(
                child: CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
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
                    image: new AssetImage(
                        "assets/images/apartments/apartment1.jpg"),
                  )),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                    image: new AssetImage(
                        "assets/images/apartments/apartment2.jpg"),
                  )),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                    image: new AssetImage(
                        "assets/images/apartments/apartment3.jpg"),
                  )),
                ),
              ],
            ))));
  }
}
