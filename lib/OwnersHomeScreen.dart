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
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'home',
                ),
                Tab(
                  icon: Icon(Icons.people),
                  text: 'tenants',
                ),
                Tab(icon: Icon(Icons.person), text: 'profile'),
                // Tab(icon: Icon(Icons.grade)),
                // Tab(icon: Icon(Icons.email)),
              ],
            ), // TabBar
            //title: const Text('GeeksForGeeks'),
            backgroundColor: Colors.blueAccent,
          ), // AppBar
          body: TabBarView(
            children: [
              HomeScreens(),
              TenantsScreen(role, phoneNumber, community_name),
              ProfileScreen(),
            ],
          ), // TabBarView
        ), // Scaffold
      ),
    );
  }
}
