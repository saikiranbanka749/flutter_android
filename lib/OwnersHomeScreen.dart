import 'package:flutter/material.dart';
import 'OwnerScreens/HomeScreens.dart';
import 'OwnerScreens/ProfileScreen.dart';
import 'OwnerScreens/TenantsScreen.dart';

class OwnerHomeScreen extends StatelessWidget {
  final String role;
  final String phoneNumber;
  final String community_name;

  OwnerHomeScreen(this.role, this.phoneNumber, this.community_name);

  @override
  Widget build(BuildContext context) {
    print(
        " this is owners home scrren   $role   $phoneNumber     $community_name"); // Logging role within build method
    return MaterialApp(
        home: Scaffold(
            body: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Allow me',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                text: 'home',
              ),
              Tab(
                icon: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                text: 'tenants',
              ),
              Tab(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  text: 'profile'),
              // Tab(icon: Icon(Icons.grade)),
              // Tab(icon: Icon(Icons.email)),
            ],
          ), // TabBar
          //title: const Text('GeeksForGeeks'),
          backgroundColor: Colors.blueAccent.shade200,
        ), // AppBar
        body: TabBarView(
          children: [
            HomeScreens(role, phoneNumber, community_name),
            TenantsScreen(role, phoneNumber, community_name),
            ProfileScreen(role, phoneNumber, community_name),
          ],
        ), // TabBarView
      ),
    ) // Scaffold

            ));
  }
}
