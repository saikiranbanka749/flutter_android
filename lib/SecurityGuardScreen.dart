import 'package:allow_me/Security_guard/ProfileScreen.dart';
import 'package:allow_me/Security_guard/VisitorsScreen.dart';
import 'package:allow_me/Security_guard/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Network/NetworkInfo.dart';

class SecurityGuardHomeScreen extends StatefulWidget {
  String text = "";

  SecurityGuardHomeScreen(String text) {
    this.text = text;
  }

  @override
  State<SecurityGuardHomeScreen> createState() =>
      SecurityGuardScreenState(text);
}

class SecurityGuardScreenState extends State<SecurityGuardHomeScreen> {
  String text = '';

  SecurityGuardScreenState(String text) {
    this.text = text;
  }

  final Screens = [VisitorsScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    print(text);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: Text(text),
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Home",
                  ),
                  Tab(
                    icon: Icon(Icons.list_rounded),
                    text: "Visitors",
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: "Profile",
                  )
                ],
              ),
              backgroundColor: Colors.blueAccent), // AppBar
          body: TabBarView(
            children: [HomeScreen(), VisitorsScreen(), ProfileScreen()],
          ), // TabBarView
        ), // Scaffold
      ),
    );
  }
}
