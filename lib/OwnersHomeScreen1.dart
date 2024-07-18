import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnerHomeScreen1 extends StatelessWidget {
  final String text, phoneNumber, role;

  OwnerHomeScreen1(this.text, this.phoneNumber, this.role);

  @override
  Widget build(BuildContext context) {
    print(text);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(text)),
        body: Container(),
      ),
    );
  }
}
