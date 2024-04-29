import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/OwnerScreens/ProfileScreen.dart';
import 'package:allow_me/Security_guard/VisitorsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Vistors_update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo("All");
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Row(
            children: [
              Text(
                'Filter',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.filter_alt),
              SizedBox(width: 320),
              PopupMenuButton<String>(
                onSelected: (value) => fetchTodo(value),
                itemBuilder: (BuildContext ctx) => [
                  PopupMenuItem(value: 'All', child: Text('All')),
                  PopupMenuItem(value: 'Pending', child: Text('Pending')),
                  PopupMenuItem(value: 'Completed', child: Text('Completed')),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
            child: Visibility(
                visible: items.isNotEmpty,
                replacement: Center(
                  child: Text("Data not availble"),
                ),
                child: // Make sure to specify the type of the map's key and value
                    ListView.separated(
                        shrinkWrap: true,
                        itemCount: items.length,
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.black87,
                            ),
                        itemBuilder: (context, index) {
                          final item = items[index] as Map<String, dynamic>;
                          return GestureDetector(
                            child: ListTile(
                              title: Text(item['visitor_name']),
                              onTap: () {
                                print(item['visitor_name']);
                                print(items.runtimeType);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Vistors_update_screen(item)));
                              },
                            ),
                          );
                        }))),
      ]),
    );
  }

  Future<void> fetchTodo(String status) async {
    print(status);
    final url = NetworkInfo.url2 + "/visitor.php?status=$status";
    final uri = Uri.parse(url);
    print("here $url");
    final response = await http.get(uri);
    print(response.statusCode);
    List data = json.decode(response.body);
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      print(data);
      setState(() {
        items = data;
        isLoading = true;
        print("is loading value is $isLoading");
      });
    } else {
      setState(() {
        items = data;
        isLoading = false;
      });
    }
  }
}
