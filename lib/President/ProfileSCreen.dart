import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  String text, president_phone_number;

  ProfileScreen(this.text, this.president_phone_number);

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState(text, president_phone_number);
}

class _ProfileScreenState extends State<ProfileScreen> {
  String text, president_phone_number;

  _ProfileScreenState(this.text, this.president_phone_number);

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['Edit Profile', 'Settings', 'Logout'];
    int index;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(title: Text(text)),
          body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    items[index],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.white38,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.white38),
              itemCount: items.length)),
    );
  }
}
