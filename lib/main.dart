import 'package:flutter/material.dart';

import '';
import 'AddOwner.dart';
import 'HomeScreen.dart';
import 'LoginTest.dart';
import 'PresidentHomeScreen.dart';
import 'SecurityGuardScreen.dart';
import 'Security_guard/SecurityAcceptScreen.dart';

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
