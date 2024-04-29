import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'OwnersHomeScreen.dart';
import 'PresidentHomeScreen.dart';
import 'SecurityGuardScreen.dart';
import 'TenantsHomeScreen.dart';
import 'TenantsHomeScreen.dart';

class LoginScreenTest extends StatelessWidget {
  String text;

  LoginScreenTest(this.text);

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

          //   appBar: AppBar(title: Text("Login"),),

          body: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 205, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.7),
                            offset: Offset(0, 7),
                            blurRadius: 20),
                      ]),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text("login",
                            style: (TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic))),
                        SizedBox(
                          height: 20,
                        ),
                        new TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            prefixIcon:
                                Icon(Icons.person, color: Colors.blueAccent),
                            label: Text(
                              "User id",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            prefixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? (Icons.visibility_off)
                                  : Icons.visibility),
                              onPressed: () {
                                _isObscure = !_isObscure;
                              },
                              color: Colors.blueAccent,
                            ),
                            label: Text(
                              "Password",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            login(context);
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white),
                        )
                      ],
                    ),
                  ))
            ],
          )
        ],
      ))),
    );
  }

  Future<void> login(BuildContext context) async {
    var phone = phoneController.text;
    var password = passwordController.text;
    if ((phone != "" && phone != null && phone.isNotEmpty) &&
        (password != "" && password != null && password.isNotEmpty)) {
      String phoneNumber = phone.toString();
      String passwordString = password.toString();
      String url = 'http://192.168.2.142/allowMe/login.php';
      var response = await http.post(Uri.parse(url),
          body: {"phone": phoneNumber, "password": passwordString});
      print(response);
      try {
        var response = await http.post(Uri.parse(url),
            body: {"phone": phoneNumber, "password": passwordString});
        var responseData = json.decode(response.body);
        print(responseData);
        List<String> words = responseData.split(' ');
        print(words);
        if (responseData == "Success") {
          print(responseData);
          if (text == "President Login") {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => PresidentHomeScreen("President")));
          } else if (text == "Owner Login") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OwnersHomeScreen(
                        "owner", phoneNumber, responseData[1])));
          } else if (text == "Tenants Login") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TenantsHomeScreen("Tenant", phone)));
          } else if (text == "SecurityGaurd Login") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecurityGuardHomeScreen("Security")));
          }
        } else {
          createAlertDialogueBox(context, "Please enter valid userId/password");
        }
      } catch (e) {
        createAlertDialogueBox(context, "Authentication Error");
      }
    } else {
      print("enter all the filed");
      createAlertDialogueBox(context, "please fill all the Fileds");
    }
  }

  createAlertDialogueBox(BuildContext context, String msg) {
    var alertDialogue = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Alert"),
      elevation: 10,
      content: Text(msg),
      actions: <Widget>[
        GestureDetector(
          child: Text("Ok"),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (builder) {
          return alertDialogue;
        });
  }
}

String? _validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter your email';
  }
}

String? _validatePassword(String value) {
  if (value.isEmpty) {
    return 'Please enter your password';
  }
}
