import 'dart:convert';

import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/widgets/DialogueBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CPassword {
  static changePassword(
      BuildContext context,
      String oldPassword,
      String newPassword,
      String phone,
      String role,
      String community_name) async {
    final body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      'phone': phone,
      "role": role,
      'community_name': community_name
    };
    String url = NetworkInfo.url2 + "/changePassword.php";
    final uri = Uri.parse(url);
    print(url);
    final response = await http.post(uri, body: jsonEncode(body));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      CustomDialogBox.DialogBox(
          context, "Password changed sucessfully", "success");
    } else if (response.statusCode == 409) {
      CustomDialogBox.DialogBox(
          context, "Old password does not matched", "warning");
    }
  }
}
