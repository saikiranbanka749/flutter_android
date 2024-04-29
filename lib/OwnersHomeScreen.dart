import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'OwnerScreens/HomeScreens.dart';
import 'OwnerScreens/ProfileScreen.dart';
import 'OwnerScreens/TenantsScreen.dart';

class OwnersHomeScreen extends StatelessWidget {
  String text, phoneNumber, role;

  OwnersHomeScreen(this.text, this.phoneNumber, this.role) {
    print("${text}   ${phoneNumber}      ${role}");
  }

  @override
  Widget build(BuildContext context) {
    print(role);
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
                    icon: Icon(Icons.people_alt_rounded),
                    text: "Visitors",
                  ),
                  Tab(
                    icon: Icon(Icons.list_rounded),
                    text: "Tenants",
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: "Profile",
                  )
                ],
              ),
              backgroundColor: Colors.blueAccent), // AppBar
          body: TabBarView(
            children: [HomeScreens(), TenantsScreen(), ProfileScreen()],
          ), // TabBarView
        ), // Scaffold
      ),
    );
  }
}
