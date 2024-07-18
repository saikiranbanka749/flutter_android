import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SnackBarWidget {
  static void scaffoldMessage(BuildContext context, String msg, String status) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: (status == "success") ? Colors.green : Colors.red,
        content: Row(
          children: <Widget>[
            // add your preferred icon here
            Icon(
              (status == "success") ? Icons.check_circle : Icons.dangerous,
              color: (status == "success" ? Colors.white : Colors.white),
            ),
            // add your preferred text content here
            Text(
              "  ${msg}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 3000),
        width: 400.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
