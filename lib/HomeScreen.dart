import 'package:allow_me/LoginTest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

class HomeScreen extends StatelessWidget {
  //build method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Column(

                      children: <Widget>[
                        SizedBox(height: 100),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 15,
                              color: Colors.green,
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen("Admin")));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 25),
                                  width: 100.0,
                                  height: 100.0,
                                  child: Text(
                                    'Admin Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'EBGaramond',
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              shadowColor: Colors.black12,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.green,
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen("President Login")));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 16),
                                  width: 100.0,
                                  height: 100.0,
                                  child: Text(
                                    'President',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'EBGaramond',
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              elevation: 15,
                              shadowColor: Colors.black12,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.green,
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen("Owner Login")));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 25),
                                  width: 100.0,
                                  height: 100.0,
                                  child: Text(
                                    'Owner',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'EBGaramond',
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              elevation: 15,
                              shadowColor: Colors.black12,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(children: [
                          SizedBox(
                            width: 30,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: Colors.green,
                            child: InkWell(
                              onTap: () {
                                print("tapped");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreen("Tenant\'s Login")));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 25),
                                width: 100.0,
                                height: 100.0,
                                child: Text(
                                  'Tenant\'s',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'EBGaramond',
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            elevation: 15,
                            shadowColor: Colors.black12,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 15,
                              color: Colors.green,
                              child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen(
                                              "SecurityGaurd Login")));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 22),
                                  width: 100.0,
                                  height: 100.0,
                                  child: Text(
                                    'Security',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'EBGaramond',
                                        fontSize: 18),
                                  ),
                                ),
                              ))
                        ]),
                        SizedBox(height: 380),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 100,
                              width: 520,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/Allow_Me.gif'))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
//        margin: EdgeInsets.only(top:300,left:120),
              ),
        ));
  }
}
