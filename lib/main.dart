import 'package:allow_me/AddApartment.dart';
import 'package:flutter/material.dart';

//import 'President/HomeScreen.dart';
import 'HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Allow me',
    color: Colors.red,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(brightness: Brightness.dark),
    themeMode: ThemeMode.system,
    home: new HomeScreen(),
  ));
}
