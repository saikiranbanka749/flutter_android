import 'dart:convert';

import 'package:allow_me/HomeScreen.dart';
import 'package:allow_me/Login.dart';
import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/PresidentHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CardData.dart';

class SuperAdmin extends StatefulWidget {
  String text;

  SuperAdmin(this.text);

  @override
  State<SuperAdmin> createState() => _SuperAdminState(text);
}

class _SuperAdminState extends State<SuperAdmin> {
  String text;
  List cardsData = [];
  bool isLoading = true;

  _SuperAdminState(this.text);

  initState() {
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    print(cardsData);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(text),
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace_outlined),
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => LoginPage("Admin")));
            },
          ),
        ),
        body: Container(
          decoration: new BoxDecoration(
            color: Color(0xfabcdefcc),
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstATop),
              image: new AssetImage('assets/apart_gif.gif'),
            ),
          ),
          child: ListView.builder(
            itemCount: cardsData.length,
            itemBuilder: (context, index) {
              final item = cardsData[index] as Map;
              // String id = item['tenant_id'];
              return Cards(item['block_name'], item['name'], item['phone']);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              NavigateToAddPage();
            },
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
            label: Text("Add NewBlock")),
      ),
    );
  }

  Future<void> fetchTodo() async {
    String url = NetworkInfo.url2 + "/users.php";
    print(url);
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    print("click me dear ${response.statusCode}");
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          json.decode(response.body).cast<Map<String, dynamic>>();
      print(data);
      setState(() {
        cardsData = data;
      });
      print("Here the cards Data is ${cardsData}");
    } else {}
    setState(() {
      isLoading = false;
    });
  }

  Widget Cards(String blockName, String ownerName, String phoneNumber) {
    print(blockName);
    return Card(
        color: Colors.black12,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PresidentHomeScreen(
                          "SuperAdmin", phoneNumber, blockName)));
            },
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        '${blockName.substring(0, 1).toUpperCase() + blockName.substring(1)} ',
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                            fontFamily: "EBGaramond"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 155),
                      child: Text(
                        '${ownerName.substring(0, 1).toUpperCase() + ownerName.substring(1)}  ',
                        style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.cyan,
                            fontFamily: "EBGaramond"),
                      ),
                    )
                  ],
                )
              ]),
            )));
  }

  Future<void> NavigateToAddPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddNewBlock()));
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }
}
