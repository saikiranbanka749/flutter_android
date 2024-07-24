import 'dart:io';

import 'package:allow_me/Provider/Setting_provider.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Admin/SuperAdmin.dart';
import 'Network/NetworkInfo.dart';
import 'OwnersHomeScreen.dart';
import 'PresidentHomeScreen.dart';
import 'SecurityGuardScreen.dart';
import 'TenantsHomeScreen.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  String text;

  LoginScreen(this.text);

  bool activeConnection = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginPage(text));
  }
}

final provider = SettingsProvider();

class LoginPage extends StatefulWidget {
  String text;

  LoginPage(this.text);

  @override
  State<StatefulWidget> createState() {
    return _myLoginPage(text);
  }
}

class _myLoginPage extends State<LoginPage> {
  String text;

  _myLoginPage(this.text);

  bool _isObsecure = false;
  bool isLoading = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    } else {}
                  },
                  icon: Icon(Icons.check)),
            )
          ],
        ),
        body: Container(
            decoration: new BoxDecoration(
              color: Color(0xfabcdefcc),
              image: new DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: new AssetImage('assets/bg.jpg'),
              ),
            ),
            child: Form(
                child: Center(
                    key: _formKey,
                    child: Form(
                        child: Container(
                      width: 400,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 250),
                          TextFormField(
                            validator: (value) =>
                                provider.validator(value!, "UserId required"),
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Cambay',
                              fontSize: 22,
                            ),
                            controller: phoneController,
                            maxLength: 10,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black87, width: 3.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black87)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.black87),
                              label: Text(
                                "User id",
                                style: TextStyle(
                                    color: Colors.black87,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    fontFamily: 'Cambay'),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          TextField(
                            obscureText: _isObsecure ? false : true,
                            controller: passwordController,
                            style: TextStyle(
                                color: Colors.black87, fontFamily: 'Cambay'),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black87, width: 3.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black87)),
                              prefixIcon: IconButton(
                                icon: Icon(_isObsecure
                                    ? (Icons.visibility)
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObsecure = !_isObsecure;
                                  });

                                  print(_isObsecure);
                                },
                                color: Colors.black87,
                              ),
                              label: Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 24,
                                  fontFamily: 'Cambay',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              login(context);
                              setState(() {
                                isLoading = true;
                              });
                              Future.delayed(const Duration(seconds: 5), () {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontFamily: 'Cambay',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                          )
                        ],
                      ),
                    ))))));
  }

  Future<void> login(BuildContext context) async {
    var phone = phoneController.text;
    var password = passwordController.text;
    var role = text;
    print("${phone}   ${password} ${role}");
    if ((phone != "" && phone != null && phone.isNotEmpty) &&
        (password != "" && password != null && password.isNotEmpty)) {
      String phoneNumber = phone.toString();
      String passwordString = password.toString();
      String url = NetworkInfo.url2 + 'login.php';
      print(url);
      final body = {
        "phone": phoneNumber,
        "password": passwordString,
        "role": role
      };
      try {
        final response = await http.post(Uri.parse(url), body: body);
        print(response.body);
        print(response.statusCode);
        var responseData = response.body.replaceAll('"', '');
        if (response.body.replaceAll('"', '') == "Error") {
          SnackBarWidget.scaffoldMessage(
              context, "Invalid User Id/password", "error");
        } else {
          List<String> myArray = responseData.split(" ");
          print("the response data is $myArray");

          if (myArray[0] == "Success") {
            // List<String> values = ['Alekya', 'plam', 'woods'];
            String combinedString = myArray.join(' ');
            print(combinedString);
            print("inside login $text");
            if (text == "Admin") {
              print("heer");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (cotntext) => SuperAdmin("Superadmin")));
              SnackBarWidget.scaffoldMessage(
                  context, "login success", "success");
            } else if (text == "President Login") {
              print(myArray);
              myArray.removeAt(0);
              print(myArray);
              String combinedString = myArray.join(' ');
              print(myArray[1]);
              print("hai ${phone}  combined String  ${combinedString}");

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (cotntext) => PresidentHomeScreen(
                          "Association President", phone, combinedString)));
              SnackBarWidget.scaffoldMessage(
                  context, "login success", "success");
              // talker.info("LOgin successfull");
            } else if (text == "Owner Login") {
              print(" owner  login success");
              myArray.removeAt(0);
              print(myArray);
              print(myArray[1]);
              String combinedString = myArray.join(' ');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OwnerHomeScreen("Owner", phone, combinedString)));
              SnackBarWidget.scaffoldMessage(
                  context, "login success", "success");
            } else if (text == "Tenant's Login") {
              myArray.removeAt(0);
              print(myArray);
              print(myArray[1]);
              print("Here teantn");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TenantsHomeScreen("Tenant", phone)));
              SnackBarWidget.scaffoldMessage(
                  context, "login success", "success");
            } else if (text == "SecurityGaurd Login") {
              print("before removing $myArray");
              myArray.removeAt(0);
              print(myArray);
              print(myArray[1]);

              String combinedString = myArray.join(' ');
              print("clicked $combinedString");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SecurityGuardHomeScreen("Security", combinedString)));
              print("reached");
              SnackBarWidget.scaffoldMessage(
                  context, "login success", "success");
            } else if (response.statusCode == 404) {
              SnackBarWidget.scaffoldMessage(
                  context, "Incorrect Username or password", "error");
            }
          }
          if (myArray[0] == "Error") {
            print("this is the error");
            SnackBarWidget.scaffoldMessage(
                context, "Incorrect Username or password", "error");
          }
        }
      } catch (e) {
        print("error ${e}");
        SnackBarWidget.scaffoldMessage(
            context, "Authentication Error, Please contact server", "error");
      }
    } else {
      SnackBarWidget.scaffoldMessage(
          context, "please fill all the Fileds", "error");
    }
  }
}
