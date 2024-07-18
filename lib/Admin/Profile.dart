import 'dart:convert';

import 'package:allow_me/Admin/SuperAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../Network/NetworkInfo.dart';
import '../President/HomeScreen.dart';
import '../widgets/Album.dart';

class Profile extends StatefulWidget {
  String phoneNumber = '';

  Profile(this.phoneNumber);

  @override
  State<StatefulWidget> createState() {
    print("phone number :$phoneNumber");
    return _ProfileState(phoneNumber);
  }
}

class _ProfileState extends State<Profile> {
  var phoneNumber;

  _ProfileState(this.phoneNumber);

  List list = [];
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchTodo();
    // HomeScreenState h = new HomeScreenState('', '', '');
    // list = h.fetchTodo() as List;
    // print(list);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('SuperAdmin')),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                FutureBuilder<List<Album>>(
                  future: futureAlbums,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<Album> albums = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: albums
                            .map((album) => buildAlbumWidget(album))
                            .toList(),
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget buildAlbumWidget(Album album) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Community name: ${album.association_name}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Role: ${album.role}', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text('President name: ${album.name}', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text('Phone number: ${album.phone}', style: TextStyle(fontSize: 16)),
        Divider(),
      ],
    );
  }

  Future<List<Album>> fetchTodo() async {
    String url = NetworkInfo.url2 +
        "users.php?role=admin&&phoneNumber=${widget.phoneNumber}";
    print("Fetching data from: $url");

    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Album> albums =
            jsonResponse.map((json) => Album.fromJson(json)).toList();
        return albums;
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
