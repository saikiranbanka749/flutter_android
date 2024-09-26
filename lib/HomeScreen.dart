import 'package:flutter/material.dart';
import 'Login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allow me'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100),
                    // First Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildCard(context, "Admin Login", "Admin"),
                          SizedBox(width: 20),
                          buildCard(
                              context, "President Login", "President Login"),
                          SizedBox(width: 20),
                          buildCard(context, "Owner Login", "Owner Login"),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Second Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildCard(
                              context, "Tenant's Login", "Tenant's Login"),
                          SizedBox(width: 20),
                          buildCard(
                              context, "Security Login", "SecurityGuard Login"),
                        ],
                      ),
                    ),
                    SizedBox(height: 150),
                    // Bottom Image
                    Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.white,
                      child: Image.asset(
                        'assets/Allow_Me.gif',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCard(BuildContext context, String buttonText, String routeName) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
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
              width: MediaQuery.of(context).size.width < 600
                  ? MediaQuery.of(context).size.width * 0.6
                  : MediaQuery.of(context).size.width * 0.2,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cambay',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          shadowColor: Colors.black12,
        ),
      ),
    );
  }
}
