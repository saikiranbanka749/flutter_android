import 'package:allow_me/Security_guard/ProfileScreen.dart';
import 'package:allow_me/Security_guard/VisitorsScreen.dart';
import 'package:allow_me/Security_guard/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Network/NetworkInfo.dart';

class SecurityGuardHomeScreen extends StatefulWidget {
  String role = "", community_name = "";

  SecurityGuardHomeScreen(String role, community_name) {
    this.role = role;
    this.community_name = community_name;
    print("thisis $community_name");
  }

  @override
  State<SecurityGuardHomeScreen> createState() =>
      SecurityGuardScreenState(role, community_name);
}

class SecurityGuardScreenState extends State<SecurityGuardHomeScreen> {
  String text = '', community_name = '';

  SecurityGuardScreenState(String text, String community_name) {
    this.text = text;
    this.community_name = community_name;
  }

  final Screens = [VisitorsScreen(""), ProfileScreen()];

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
                    text: "Add visitor",
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: "Profile",
                  )
                ],
              ),
              backgroundColor: Colors.blueAccent), // AppBar
          body: TabBarView(
            children: [
              HomeScreen(),
              VisitorsScreen(community_name),
              ProfileScreen()
            ],
          ), // TabBarView
        ), // Scaffold
      ),
    );
  }
}
