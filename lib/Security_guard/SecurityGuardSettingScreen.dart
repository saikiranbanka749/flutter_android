import 'package:allow_me/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecurityGuardSettingScreen extends StatefulWidget {
  const SecurityGuardSettingScreen({super.key});

  @override
  State<SecurityGuardSettingScreen> createState() =>
      _SecurityGuardSettingScreenState();
}

class _SecurityGuardSettingScreenState
    extends State<SecurityGuardSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () {
                print("go bck");
                //  Navigator.of(context).push();
              },
            ),
          ),
          body: Container()),
    );
  }
}
