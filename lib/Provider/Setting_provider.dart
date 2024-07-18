import 'package:flutter/cupertino.dart';

class SettingsProvider extends ChangeNotifier {
  validator(String value, String message) {
    if (value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }
}
