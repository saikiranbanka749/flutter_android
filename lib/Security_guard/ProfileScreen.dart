import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SecurityGuardSettingScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List items = ['Settings', 'Additional Settings', 'Logout'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ListView.separated(
          itemCount: items.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final item = items.toList();
            print(item[index]);
            return new GestureDetector(
                onTap: () {
                  print(item[index].toString());
                },
                child: Container(
                    child: ListTile(
                        title: Text(
                  item[index].toString(),
                  style: TextStyle(fontSize: 26),
                ))));
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Theme.of(context).primaryColor,
            );
          },
        )));
  }
}
