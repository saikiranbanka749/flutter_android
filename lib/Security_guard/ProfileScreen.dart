import 'package:flutter/material.dart';

import 'SecurityGuardSettingScreen.dart';
// Import any other screens as necessary

class ProfileScreen extends StatefulWidget {
  String text = '', phone = '', community_name = '';

  ProfileScreen(String text, String phone, String community_name) {
    this.text = text;
    this.phone = phone;
    this.community_name = community_name;
  }

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState(text, phone, community_name);
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> items = [
    {'title': 'Settings', 'icon': Icons.settings},
    // {'title': 'Additional Settings', 'icon': Icons.more_horiz},
    {'title': 'Logout', 'icon': Icons.logout},
  ];

  String text = '', phone = '', community_name = '';

  _ProfileScreenState(this.text, this.phone, this.community_name);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600; // Adjust this threshold as needed

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isWideScreen ? 40 : 16),
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10); // Space between tiles
          },
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                if (item['title'] == 'Settings') {
                  // Navigate to Settings screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecurityGuardSettingScreen(
                          text, phone, community_name),
                    ),
                  );
                } else if (item['title'] == 'Logout') {
                  // Handle logout logic here
                  _logout();
                }
                // Add more conditions for other list items if needed
              },
              child: ListTile(
                leading: Icon(
                  item['icon'],
                  color: Colors.blue,
                  size: isWideScreen ? 30 : 24, // Responsive icon size
                ),
                title: Text(
                  item['title'],
                  style: TextStyle(
                    fontSize: isWideScreen ? 22 : 20, // Responsive text size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: isWideScreen ? 24 : 20, // Responsive trailing icon size
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isWideScreen ? 24 : 16,
                  vertical: isWideScreen ? 16 : 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _logout() {
    // Implement your logout logic here, e.g., clearing session data, navigating to login screen
    print('Logging out...');
    // Navigate back to login screen or perform any logout operations
  }
}
