import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30),
                    buildCard(
                      context,
                      "Admin Login",
                      "Admin",
                    ),
                    SizedBox(width: 30),
                    buildCard(
                      context,
                      "President Login",
                      "President Login",
                    ),
                    SizedBox(width: 30),
                    buildCard(
                      context,
                      "Owner Login",
                      "Owner Login",
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30),
                    buildCard(
                      context,
                      "Tenant's Login",
                      "Tenant\'s Login",
                    ),
                    SizedBox(width: 30),
                    buildCard(
                      context,
                      "Security Login",
                      "SecurityGaurd Login",
                    ),
                  ],
                ),
                SizedBox(height: 380),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 520,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/Allow_Me.gif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String buttonText, String routeName) {
    return Card(
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
              builder: (context) => LoginScreen(routeName),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          width: 130.0,
          height: 130.0,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cambay',
              fontSize: 20,
            ),
          ),
        ),
      ),
      shadowColor: Colors.black12,
    );
  }
}
