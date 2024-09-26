import 'package:allow_me/Admin/SuperAdmin.dart';
import 'package:allow_me/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Association extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Association();
}

class _Association extends State<Association> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Super Admin'),
              leading: IconButton(
                icon: Icon(Icons.keyboard_backspace_outlined),
                onPressed: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage('Allow me')));
                },
              ),
            ),
            body: Container()));
  }
}
