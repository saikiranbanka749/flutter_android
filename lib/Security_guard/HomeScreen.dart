import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../Reports/DownloadSecurityReports.dart';
import '../widgets/Blinking_toolTip.dart';
import 'Vistors_update_screen.dart';
import '../Network/NetworkInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  String role = '', community_name = '';

  HomeScreen(String role, String community_name) {
    this.role = role;
    this.community_name = community_name;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState(role, community_name);
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _timer;
  int _blinkCount = 0;
  final int _maxBlinks = 5;
  final Duration _blinkInterval = Duration(milliseconds: 500);
  String role = '', community_name = '';

  _HomeScreenState(String role, String community_name) {
    this.role = role;
    this.community_name = community_name;
  }

  bool isLoading = true;
  List<Map<String, dynamic>> items = [];

  String selectedValue = "All";

  @override
  void initState() {
    super.initState();
    fetchVisitors("All");
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  void _startBlinkState() {
    _timer = Timer.periodic(_blinkInterval, (timer) {
      setState(() {
        _blinkCount++;
        if (_blinkCount >= _maxBlinks) {
          _timer.cancel();
          _animationController.stop();
        }
      });
    });
  }

  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitors'),
        actions: [
          BlinkingTooltip(
            message: 'Download Reports',
            child: IconButton(
              icon: Icon(Iconsax.document_download),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DownloadSecurityReports(),
                  ),
                );
              },
            ),
            blinkCount: 5, // Blinks 5 times
          ),
          PopupMenuButton<String>(
            onSelected: (value) => fetchVisitors(value),
            itemBuilder: (BuildContext ctx) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      (selectedValue == "All") ? Icons.done_all : Icons.done,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Text('All'),
                  ],
                ),
                value: 'All',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      (selectedValue == "Pending")
                          ? Icons.done_all
                          : Icons.done,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Text('Pending')
                  ],
                ),
                value: 'Pending',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      (selectedValue == "Completed")
                          ? Icons.done_all
                          : Icons.done,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Text('Completed')
                  ],
                ),
                value: 'Completed',
              ),
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
      selectedValue = status;
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
        builder: (context) => VisitorsUpdateScreen(item, role, community_name),
      ),
    );
  }
}
