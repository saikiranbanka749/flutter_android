import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tenants/Visitors.dart';
import 'tenants/RequestingScreen.dart';

class TenantsHomeScreen extends StatelessWidget {
  String text, phone;

  TenantsHomeScreen(this.text, this.phone);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "visitors", icon: Icon(Icons.people_alt_rounded)),
                Tab(icon: Icon(Icons.edit_note_sharp), text: "Create requests"),
                //  Tab(icon: Icon(Icons.camera_alt), text: "home"),
              ],
            ), // TabBar
            title: Text(text),
            backgroundColor: Colors.blueAccent,
          ), // AppBar
          body: TabBarView(
            children: [
              VisitorsScreen(phone),
              RequesingScreen(),
            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController
    ); // MaterialApp
  }
}
