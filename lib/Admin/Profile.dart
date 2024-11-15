import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Network/NetworkInfo.dart';
import '../widgets/Album.dart';
import '../widgets/Albums.dart';

class Profile extends StatefulWidget {
  final String phoneNumber;

  Profile(this.phoneNumber);

  @override
  State<StatefulWidget> createState() {
    return _ProfileState(phoneNumber);
  }
}

class _ProfileState extends State<Profile> {
  final String phoneNumber;

  _ProfileState(this.phoneNumber);

  late Future<List<Album>> futureAlbums;
  late Future<List<Albums>> apartmentData;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchTodo();
    apartmentData = fetchApartmentsDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('SuperAdmin'),
        ),
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
              Expanded(
                child: FutureBuilder<List<Albums>>(
                  future: apartmentData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<Albums> albums = snapshot.data!;
                      return ListView(
                        children: albums
                            .map((album) => buildExpandableAlbumWidget(album))
                            .toList(),
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildExpandableAlbumWidget(Albums album) {
    return ExpansionTile(
      title: Text(album.apartment_name),
      trailing: Icon(Icons.arrow_drop_down),
      children: <Widget>[
        ListTile(
          title: Text('Available Flats: ${album.available_flats}'),
        ),
        ListTile(
          title: Text('Filled Flats: ${album.filled_flats}'),
        ),
      ],
    );
  }

  Future<List<Album>> fetchTodo() async {
    String url =
        NetworkInfo.url2 + "users.php?role=admin&phoneNumber=${phoneNumber}";
    print("Fetching data from: $url");

    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Album> albums =
            jsonResponse.map<Album>((json) => Album.fromJson(json)).toList();
        return albums;
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<List<Albums>> fetchApartmentsDetails() async {
    print("Fetching apartment details");

    String url =
        '${NetworkInfo.url2}flats.php?phoneNumber=${phoneNumber}&screen=president';
    print("Fetching data from: $url");

    try {
      final response = await http.get(Uri.parse(url));
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("Parsed JSON response: $jsonResponse");

        if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
          List<dynamic> jsonList = jsonResponse['data'];
          List<Albums> albums =
              jsonList.map((json) => Albums.fromJson(json)).toList();

          print("Albums fetched: ${albums}");
          return albums;
        } else {
          throw Exception(
              'Unexpected JSON structure: Missing or invalid data key');
        }
      } else {
        throw Exception(
            'Failed to load apartments details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchApartmentsDetails: $e');
      throw Exception('Failed to fetch apartments details: $e');
    }
  }
}
