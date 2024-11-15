import 'dart:io';

import 'package:allow_me/Provider/Setting_provider.dart';
import 'package:allow_me/widgets/DialogueBox.dart';
import 'package:allow_me/widgets/Message_box.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Admin/SuperAdmin.dart';
import 'Network/NetworkInfo.dart';
import 'OwnersHomeScreen.dart';
import 'PresidentHomeScreen.dart';
import 'Reports/Test.dart';
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
                            onPressed: () async {
                              login(context);
                              setState(() {
                                isLoading = true;
                              });
                              Future.delayed(const Duration(seconds: 10), () {
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
      String url = NetworkInfo.url2 + '/login.php';
      print(url);
      final body = {
        "phone": phoneNumber,
        "password": passwordString,
        "role": role
      };
      final response = await http.post(Uri.parse(url), body: body);
      print("response ${response.body}");
      try {
        final response = await http.post(Uri.parse(url), body: body);
        var responseData = json.decode(response.body).replaceAll('"', '');
        print("here ${response.body}");
        List<String> myArray = responseData.split(" ");
        print(myArray);
        String communityName = myArray.skip(1).join(" ");
        print("Community Name: $communityName");
        if (myArray[0] == "Success") {
          print("inside login $text");
          if (text == "Admin") {
            print("heer");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (cotntext) => SuperAdmin("Super admin")));
            SnackBarWidget.scaffoldMessage(context, "login success", "success");
          } else if (text == "President Login") {
            print("hai ${phone} ");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (cotntext) => PresidentHomeScreen(
                        "Associatin President", phone, myArray[1])));
            SnackBarWidget.scaffoldMessage(context, "login success", "success");
            // talker.info("LOgin successfull");
          } else if (text == "Owner Login") {
            print("login success");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OwnerHomeScreen("Owner", phone, myArray[2])));
            SnackBarWidget.scaffoldMessage(context, "login success", "success");
          } else if (text == "Tenant's Login") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TenantsHomeScreen("Tenant", phone, communityName)));
            SnackBarWidget.scaffoldMessage(context, "login success", "success");
          } else if (text == "SecurityGuard Login") {
            print("clicked $text");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecurityGuardHomeScreen(
                        "Security", phoneNumber, communityName)));
            print("reached");
            SnackBarWidget.scaffoldMessage(context, "login success", "success");
          }
        }
      } catch (e) {
        print("error");
        SnackBarWidget.scaffoldMessage(
            context, "Authentication Error, Please contact server", "error");
      }
    } else {
      SnackBarWidget.scaffoldMessage(
          context, "please fill all the Fileds", "error");
    }
  }
}
