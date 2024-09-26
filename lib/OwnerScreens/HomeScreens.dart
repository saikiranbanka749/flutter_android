import 'package:flutter/material.dart';
import 'dart:convert';
import '../Network/NetworkInfo.dart';
import 'package:http/http.dart' as http;

class HomeScreens extends StatefulWidget {
  final String role;
  final String president_phone_number;
  final String community_name;

  HomeScreens(this.role, this.president_phone_number, this.community_name);

  @override
  State<HomeScreens> createState() =>
      _HomeScreensState(role, president_phone_number, community_name);
}

class _HomeScreensState extends State<HomeScreens> {
  bool isLoading = true;
  String role;
  String president_phone_number;
  String community_name;
  List items = [];

  _HomeScreensState(
      this.role, this.president_phone_number, this.community_name);

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Owner Flats'),
      //   backgroundColor: Colors.blueAccent,
      // ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height *
                    0.7, // Ensure this is not too large
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                      elevation: 5,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] ?? 'No Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Community: ${item['community_name'] ?? 'N/A'}",
                                  style: TextStyle(
                                    fontSize:
                                        ((item['community_name']?.length ?? 0) >
                                                    14 &&
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    600))
                                            ? 13
                                            : 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text("Block: ${item['block_name'] ?? 'N/A'}"),
                                SizedBox(height: 8),
                                Text("Flat: ${item['flat_number'] ?? 'N/A'}"),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              )),
    );
  }

  Future<void> fetchTodo() async {
    print("my Phone Number: $president_phone_number   Role: $role");
    try {
      String url = NetworkInfo.url2 +
          "/owners_flats.php?phone_number=${Uri.encodeComponent(president_phone_number)}&role=${Uri.encodeComponent(role)}";
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          items = data;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load data, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
}
