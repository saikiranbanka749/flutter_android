import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:allow_me/Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../AddApartment.dart';
import '../Network/NetworkInfo.dart';

class HomeScreen extends StatefulWidget {
  String title, president_phone, block_name;

  HomeScreen(this.title, this.president_phone, this.block_name);

  @override
  State<StatefulWidget> createState() =>
      HomeScreenState(title, president_phone, block_name);
}

class HomeScreenState extends State<HomeScreen> {
  String title, president_phone, block_name;
  List<dynamic> data = [];

  HomeScreenState(this.title, this.president_phone, this.block_name);

  @override
  void initState() {
    fetchTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen("President Login"),
              ),
            );
          },
        ),
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 900.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                'assets/images/apartments/apartment1.jpg',
                'assets/images/apartments/apartment2.jpg',
                'assets/images/apartments/apartment3.jpg',
              ].map((item) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Apartments',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddApartment(title, president_phone, block_name),
                        ),
                      );
                    },
                    child: Text(
                      'Add Apartment',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columnSpacing: (screenWidth >= 600) ? 10 : 2,
                headingRowHeight: 60,
                dataRowHeight: 60,
                horizontalMargin: 20,
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: screenWidth * 0.2, // Example dynamic width
                      child: Center(
                          child: Text(
                        (screenWidth <= 600)
                            ? 'Apartment \n  Name'
                            : 'Apartment Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth <= 600 ? 12 : 16,
                        ),
                      )),
                    ),
                  ),
                  DataColumn(
                      label: SizedBox(
                    width: screenWidth * 0.2, // Example dynamic width
                    child: Center(
                        child: Text(
                      (screenWidth <= 600)
                          ? 'Community\n'
                              '  Name'
                          : 'Community Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth <= 600 ? 12 : 16,
                      ),
                    )),
                  )),
                  DataColumn(
                    label: SizedBox(
                        width: screenWidth * 0.2, // Example dynamic width
                        child: Center(
                          child: Text(
                            'No of Flats',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth <= 600 ? 12 : 16,
                            ),
                          ),
                        )),
                  ),
                  DataColumn(
                    label: SizedBox(
                        width: screenWidth * 0.2, // Example dynamic width
                        child: Center(
                          child: Text(
                            'No of \n Floors',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth <= 600 ? 12 : 16,
                            ),
                          ),
                        )),
                  ),
                  DataColumn(
                    label: SizedBox(
                        // Example dynamic width
                        child: Text(
                      '  Flats\nper floor',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth <= 600 ? 12 : 16,
                      ),
                    )),
                  ),
                ],
                rows: data.map((item) {
                  return DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        // Alternate row color
                        return data.indexOf(item) % 2 == 0
                            ? Colors.grey[100]
                            : Colors.white;
                      },
                    ),
                    cells: [
                      DataCell(Center(
                        child: Text(
                          item['apartment_name'].toString(),
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        ),
                      )),
                      DataCell(
                        Center(
                            child: Text(
                          item['community_name'].toString(),
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        )),
                      ),
                      DataCell(
                        Center(
                            child: Text(
                          item['no_of_plots'].toString(),
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        )),
                      ),
                      DataCell(
                        Center(
                            child: Text(
                          item['no_of_floors'].toString(),
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        )),
                      ),
                      DataCell(Center(
                        child: Text(
                          item['plot_per_floor'].toString(),
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        ),
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchTodo() async {
    final url =
        NetworkInfo.url2 + "/addApartment.php?phone_number=$president_phone";
    final uri = Uri.parse(url);
    print(url);
    final response = await http.get(uri);
    print(response.body);
    try {
      setState(() {
        data = json.decode(response.body);
      });
      print("Fetched data: $data");
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
