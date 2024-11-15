import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Network/NetworkInfo.dart';
import '../Security_guard/Vistors_update_screen.dart';

class VisitorsScreen extends StatefulWidget {
  String phone_number = "", community_name = '';

  VisitorsScreen(String phone_number, String community_name) {
    this.phone_number = phone_number;
    this.community_name = community_name;
  }

  @override
  State<VisitorsScreen> createState() =>
      _VisitorsScreenState(phone_number, community_name);
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  var items = [];
  bool isLoading = false;
  String phone_number = "", community_name = '';
  String selectedValue = "All";

  _VisitorsScreenState(String phone_number, String community_name) {
    this.phone_number = phone_number;
    this.community_name = community_name;
  }

  @override
  void initState() {
    fetchTodo("All", phone_number);
    String selectedValue = "All";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Visitors Screen'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) => fetchTodo(value, phone_number),
              itemBuilder: (BuildContext ctx) => [
                PopupMenuItem(
                  value: 'All',
                  child: Row(
                    children: [
                      Icon(
                        selectedValue == 'All' ? Icons.done_all : Icons.done,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('All'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Pending',
                  child: Row(
                    children: [
                      Icon(
                        selectedValue == 'Pending'
                            ? Icons.done_all
                            : Icons.done,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('Pending'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Completed',
                  child: Row(
                    children: [
                      Icon(
                        selectedValue == 'Completed'
                            ? Icons.done_all
                            : Icons.done,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('Completed'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.filter_alt),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Visibility(
                visible: items.isNotEmpty,
                replacement: Center(
                  child: Text("Data not available"),
                ),
                child: !isLoading
                    ? Center(child: CircularProgressIndicator())
                    : items.isEmpty
                        ? Center(child: Text("Data not available"))
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: items.length,
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.black87,
                            ),
                            itemBuilder: (context, index) {
                              final item = items[index] as Map<String, dynamic>;
                              return GestureDetector(
                                onTap: () {
                                  print(item['visitor_name']);
                                  print(items.runtimeType);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VisitorsUpdateScreen(
                                              item, 'tenant', community_name),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(item['visitor_name']),
                                  subtitle: Text(item['status']),
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchTodo(String value, String phone_number) async {
    setState(() {
      isLoading = true;
      selectedValue = value;
    });

    print(phone_number);
    try {
      String url = NetworkInfo.url2 +
          "t_visitors.php?status=${value}&phone=${phone_number}";
      final uri = Uri.parse(url);
      print("Requesting URL: $url");

      final response = await http.get(uri);
      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        setState(() {
          if (decoded is Map<String, dynamic>) {
            // Wrap Map in List if single record is returned
            items = [decoded];
          } else if (decoded is List) {
            // Directly assign if response is already a List
            items = List<Map<String, dynamic>>.from(decoded);
          }
          isLoading = true;
        });
      } else if (response.statusCode == 204) {
        setState(() {
          items = []; // Empty list if no content
          isLoading = false;
        });
        print("No data found for the given filters.");
      } else {
        setState(() {
          items = [];
          isLoading = false;
        });
        print("Error: Unexpected response status ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        items = [];
        isLoading = false;
      });
    }
  }
}
