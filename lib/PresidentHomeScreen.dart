import 'package:allow_me/Security_guard/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'Admin/Profile.dart';
import 'President/HomeScreen.dart';
import 'President/OwnerScreen.dart';
import 'President/SecurityScreen.dart';
import 'President/TenantsScreen.dart';

class PresidentHomeScreen extends StatefulWidget {
  String role, president_phone, block_name;

  PresidentHomeScreen(this.role, this.president_phone, this.block_name);

  @override
  _HomePageState createState() {
    print("its me ${president_phone}");
    return _HomePageState(role, president_phone, block_name);
  }
}

class _HomePageState extends State<PresidentHomeScreen> {
  String role = "", president_phone_number = "", block_name = "";
  var pageOptions = [];

  _HomePageState(String role, String president_phone, String block_name) {
    this.block_name = block_name;
    print("president scrren $block_name");
    this.role = role;
    this.president_phone_number = president_phone;
    // this.ph_num = ph_num;
    print(role);
    pageOptions = [
      if (role != "SuperAdmin")
        HomeScreen('title', president_phone, block_name),
      OwnersScreen(role == "SuperAdmin" ? "Super Admin" : 'Owner',
          president_phone, block_name, role),
      TenantsScreen(
          role == "SuperAdmin"
              ? "Super Admin"
              : ((role == "President") ||
                      (role == "AssociationPresident") ||
                      (role == "Association President"))
                  ? "AssociationPresident"
                  : 'Tenant',
          president_phone,
          block_name,
          ((role == "President") ||
                  (role == "AssociationPresident") ||
                  (role == "Association President"))
              ? "AssociationPresident"
              : role),
      SecurityScreen(role == "SuperAdmin" ? "Super Admin" : 'Security',
          president_phone_number, block_name, role),
      ((role != "SuperAdmin")
          ? ProfileScreen(
              "Association President", president_phone_number, block_name)
          : Profile(president_phone))
    ];
  }

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    print(pageOptions);
    print(role);
    return Scaffold(
        backgroundColor: Colors.white,
        body: pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            if (role != "SuperAdmin")
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Owner'),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded),
              label: 'Tenants',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_police), label: 'Security'),
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
