import 'package:allow_me/Security_guard/ProfileScreen.dart';
import 'package:allow_me/Security_guard/VisitorsScreen.dart';
import 'package:allow_me/Security_guard/HomeScreen.dart';
import 'package:flutter/material.dart';

class SecurityGuardHomeScreen extends StatefulWidget {
  final String role;
  final String phone;
  final String communityName;

  SecurityGuardHomeScreen(this.role, this.phone, this.communityName);

  @override
  State<SecurityGuardHomeScreen> createState() =>
      SecurityGuardScreenState(role, phone, communityName);
}

class SecurityGuardScreenState extends State<SecurityGuardHomeScreen> {
  final String text;
  final String phone;
  final String communityName;

  SecurityGuardScreenState(this.text, this.phone, this.communityName);

  final List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens.addAll([
      HomeScreen(text, communityName),
      VisitorsScreen(communityName),
      ProfileScreen(text, phone, communityName),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(text),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: "Home"),
                Tab(icon: Icon(Icons.list_rounded), text: "Add Visitor"),
                Tab(icon: Icon(Icons.person), text: "Profile"),
              ],
            ),
            backgroundColor: Colors.blueAccent,
          ),
          body: TabBarView(
            children: screens,
          ),
        ),
      ),
    );
  }
}
