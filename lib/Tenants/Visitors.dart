import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Network/NetworkInfo.dart';

class VisitorsScreen extends StatefulWidget {
  String phone_number = "";

  VisitorsScreen(String phone_number) {
    this.phone_number = phone_number;
  }

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState(phone_number);
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  var items = [];
  bool isLoading = false;
  String phone_number = "";

  _VisitorsScreenState(String phone_number) {
    this.phone_number = phone_number;
  }

  @override
  void initState() {
    fetchTodo("All", phone_number);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                    onSelected: (value) => fetchTodo(value, phone_number),
                    itemBuilder: (BuildContext ctx) => [
                      PopupMenuItem(value: 'All', child: Text('All')),
                      PopupMenuItem(value: 'Pending', child: Text('Pending')),
                      PopupMenuItem(
                          value: 'Completed', child: Text('Completed')),
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
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             Vistors_update_screen(item)));
                                  },
                                ),
                              );
                            }))),
          ]),
        ));
  }

  Future<void> fetchTodo(String value, String phone_number) async {
    print(phone_number);
    String url = NetworkInfo.url2 +
        "t_visitors.php?status=${value}&phone=${phone_number}";
    final uri = Uri.parse(url);
    print("here $url");
    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
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
