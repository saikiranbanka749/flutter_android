import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class CustomDialogBox {
  static Future<void> DialogBox(
      BuildContext context, String msg, String type) async {
    await dialogueAlertBox(context, msg, type);
  }

  static Future<void> dialogueAlertBox(
      BuildContext context, String msg, String type) async {
    return QuickAlert.show(
      context: context,
      type: _getQuickAlertType(type),
      title: _getTitle(type),
      text: msg,
      confirmBtnText: 'OK',
      onConfirmBtnTap: () {
        Navigator.of(context, rootNavigator: true).pop();
        //Navigator.of(context).pop();
      },
    );
  }

  static QuickAlertType _getQuickAlertType(String type) {
    switch (type) {
      case 'error':
        return QuickAlertType.error;
      case 'success':
        return QuickAlertType.success;
      case 'warning':
        return QuickAlertType.warning;
      default:
        return QuickAlertType.info;
    }
  }

  static String _getTitle(String type) {
    switch (type) {
      case 'error':
        return 'ERROR';
      case 'success':
        return 'SUCCESS';
      case 'warning':
        return 'WARNING';
      default:
        return 'INFO';
    }
  }
}
