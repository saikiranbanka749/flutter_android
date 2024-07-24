import 'package:allow_me/AddApartment.dart';
import 'package:flutter/material.dart';

//import 'President/HomeScreen.dart';
import 'HomeScreen.dart';

void main() {
  runApp(MaterialApp(
      title: 'Allow me',
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Allow me", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueAccent,
        ),
        body: new HomeScreen(),
      )));
}
