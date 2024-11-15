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
  final String role;
  final String communityName;

  HomeScreen(this.role, this.communityName);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _timer;
  int _blinkCount = 0;
  final int _maxBlinks = 5;
  final Duration _blinkInterval = Duration(milliseconds: 500);

  bool isLoading = true;
  List<Map<String, dynamic>> items = [];
  String selectedValue = "All";

  @override
  void initState() {
    super.initState();
    fetchVisitors(selectedValue);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitors', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          BlinkingTooltip(
            message: 'Download Reports',
            child: IconButton(
              icon: Icon(Iconsax.document_download),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DownloadSecurityReports()),
                );
              },
            ),
            blinkCount: _maxBlinks,
          ),
          _buildPopupMenu(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return isLoading
                  ? Center(child: CircularProgressIndicator())
                  : items.isNotEmpty
                      ? ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          // Space between items
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return GestureDetector(
                              onTap: () => navigateToVisitorUpdateScreen(item),
                              child: Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  // Padding inside the card
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['visitor_name'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 4),
                                      // Space between title and subtitle
                                      Text(item['status']),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(child: Text("Data not available"));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      onSelected: (value) => fetchVisitors(value),
      itemBuilder: (BuildContext ctx) {
        return [
          _buildPopupMenuItem('All'),
          _buildPopupMenuItem('Pending'),
          _buildPopupMenuItem('Completed'),
        ];
      },
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(
            selectedValue == value ? Icons.done_all : Icons.done,
            color: Colors.black,
          ),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  Future<void> fetchVisitors(String status) async {
    setState(() {
      isLoading = true;
      selectedValue = status;
    });

    final url = '${NetworkInfo.url2}/visitor.php?status=$status';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {
        items = data;
        isLoading = false;
      });
    } else {
      setState(() {
        items.clear();
        isLoading = false;
      });
      _showErrorDialog('Visitors not found');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void navigateToVisitorUpdateScreen(Map<String, dynamic> item) {
    print(item);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              VisitorsUpdateScreen(item, widget.role, widget.communityName)),
    );
  }
}
