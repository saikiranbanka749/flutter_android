import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../President/OwnerScreen.dart';

import '../President/ProfileSCreen.dart';
import '../President/SecurityScreen.dart';
import '../President/TenantsScreen.dart';

class MoonBlock extends StatefulWidget {
  String text;

  MoonBlock(this.text);

  @override
  State<MoonBlock> createState() => _MoonBlockState(text);
}

class _MoonBlockState extends State<MoonBlock> {
  String title = "";

  var pageOptions = [];

  _MoonBlockState(title) {
    this.title = title;
    //  this.president_phone_number = president_phone;
    pageOptions = [
      OwnersScreen('Owner', "", ""),
      TenantsScreen('Tenant', "", ""),
      SecurityScreen('Security', "", ""),
      ProfileScreen("Profile", "")
    ];
  }

  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    print(pageOptions);
    return Scaffold(
        backgroundColor: Colors.white,
        body: pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: [
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
