import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenSized extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDesktop(BuildContext context) =>
        MediaQuery.of(context).size.width > 600;

    bool isMobile(BuildContext context) =>
        MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body: Center(
        child: Text(''),
      ),
    );
  }
}
