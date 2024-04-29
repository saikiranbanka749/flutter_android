import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'President/HomeScreen.dart';
import 'President/OwnerScreen.dart';
import 'President/ProfileSCreen.dart';
import 'President/SecurityScreen.dart';
import 'President/TenantsScreen.dart';

class PresidentHomeScreen extends StatefulWidget {
  String text, president_phone, block_name;

  PresidentHomeScreen(this.text, this.president_phone, this.block_name);

  @override
  _HomePageState createState() {
    print("its me ${president_phone}");
    return _HomePageState(text, president_phone, block_name);
  }
}

class _HomePageState extends State<PresidentHomeScreen> {
  String title = "", president_phone_number = "", block_name = "";
  var pageOptions = [];

  _HomePageState(String title, String president_phone, String block_name) {
    this.block_name = block_name;
    print("president scrren $block_name");
    this.title = title;
    this.president_phone_number = president_phone;
    print(title);
    pageOptions = [
      if (title != "SuperAdmin") HomeScreen(),
      OwnersScreen(title == "SuperAdmin" ? "Super Admin" : 'Owner',
          president_phone, block_name),
      TenantsScreen(title == "SuperAdmin" ? "Super Admin" : 'Tenant',
          president_phone, block_name),
      SecurityScreen(title == "SuperAdmin" ? "Super Admin" : 'Security',
          president_phone_number, block_name),
      if (title != "SuperAdmin") {ProfileScreen("Profile", president_phone)}
    ];
  }

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    print(pageOptions);
    print(title);
    return Scaffold(
        backgroundColor: Colors.white,
        body: pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            if (title != "SuperAdmin")
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Owner'),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded),
              label: 'Tenants',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_police), label: 'Security'),
            if (title != "SuperAdmin")
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile'),
          ],
          selectedItemColor: Colors.green,
          elevation: 5.0,
          unselectedItemColor: Colors.green[900],
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
