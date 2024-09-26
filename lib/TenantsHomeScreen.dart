import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Tenants/RequestingScreen.dart';
import 'tenants/Visitors.dart';

class TenantsHomeScreen extends StatelessWidget {
  String text, phone, community_name;

  TenantsHomeScreen(this.text, this.phone, this.community_name);

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
              VisitorsScreen(phone, community_name),
              RequestingScreen(phone, community_name),
            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController
    ); // MaterialApp
  }
}
