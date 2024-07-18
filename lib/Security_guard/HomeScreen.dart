import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Network/NetworkInfo.dart';
import 'Vistors_update_screen.dart'; // Adjust path as per your project structure

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchVisitors("All");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitors'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => fetchVisitors(value),
            itemBuilder: (BuildContext ctx) => [
              PopupMenuItem(value: 'All', child: Text('All')),
              PopupMenuItem(value: 'Pending', child: Text('Pending')),
              PopupMenuItem(value: 'Completed', child: Text('Completed')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return isLoading
                ? Center(child: CircularProgressIndicator())
                : items.isNotEmpty
                    ? ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black87,
                        ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: () => navigateToVisitorUpdateScreen(item),
                            child: ListTile(
                              title: Text(item['visitor_name']),
                              subtitle: Text(item['status']),
                            ),
                          );
                        },
                      )
                    : Center(child: Text("Data not available"));
          },
        ),
      ),
    );
  }

  Future<void> fetchVisitors(String status) async {
    setState(() {
      isLoading = true;
    });

    final url = NetworkInfo.url2 +
        "/visitor.php?status=$status"; // Replace with your actual URL
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data = json
          .decode(response.body)
          .cast<Map<String, dynamic>>(); // Ensure data is correctly typed
      setState(() {
        items = data;
        isLoading = false;
      });
    } else {
      setState(() {
        items.clear(); // Clear previous items
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Visitors not found'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void navigateToVisitorUpdateScreen(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VisitorsUpdateScreen(item),
      ),
    );
  }
}
