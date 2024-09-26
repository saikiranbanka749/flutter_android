import 'package:flutter/material.dart' hide CarouselController;
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

  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: screenHeight * 0.6,
              child: CarouselSlider(
                options: CarouselOptions(
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
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Row(
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
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddApartment(
                                title, president_phone, block_name),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: (screenWidth >= 600) ? 10 : 2,
                headingRowHeight: 60,
                dataRowHeight: 60,
                horizontalMargin: 20,
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: screenWidth * 0.2,
                      child: Center(
                          child: Text(
                        (screenWidth <= 600) ? 'Block \n  Name' : 'Block Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth <= 600 ? 12 : 16,
                        ),
                      )),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: screenWidth * 0.2,
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
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: screenWidth * 0.2,
                      child: Center(
                        child: Text(
                          'No of Flats',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth <= 600 ? 12 : 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: screenWidth * 0.2,
                      child: Center(
                        child: Text(
                          'No of \n Floors',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth <= 600 ? 12 : 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: screenWidth <= 600
                          ? screenWidth * 0.2
                          : screenWidth * 0.1,
                      child: Text(
                        '  Flats\nper floor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth <= 600 ? 12 : 16,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: screenWidth * 0.1,
                      child: Text(
                        'Actions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth <= 600 ? 12 : 16,
                        ),
                      ),
                    ),
                  ),
                ],
                rows: data.map((item) {
                  return DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return data.indexOf(item) % 2 == 0
                            ? Colors.grey[100]
                            : Colors.white;
                      },
                    ),
                    cells: [
                      DataCell(Center(
                        child: Text(
                          (item['apartment_name'] != null &&
                                  item['apartment_name'].isNotEmpty)
                              ? item['apartment_name'].toString()
                              : 'N/A',
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        ),
                      )),
                      DataCell(
                        Center(
                            child: Text(
                          (item['community_name'] != null &&
                                  item['community_name'].isNotEmpty)
                              ? item['community_name'].toString()
                              : 'N/A',
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        )),
                      ),
                      DataCell(
                        Center(
                            child: Text(
                          (item['no_of_plots'] != null &&
                                  item['no_of_plots'].isNotEmpty)
                              ? item['no_of_plots'].toString()
                              : 'N/A',
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        )),
                      ),
                      DataCell(Center(
                        child: Text(
                          (item['no_of_floors'] != null &&
                                  item['no_of_floors'].isNotEmpty)
                              ? item['no_of_floors'].toString()
                              : 'N/A',
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        ),
                      )),
                      DataCell(Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (item['plot_per_floor'] != null &&
                                  item['plot_per_floor'].isNotEmpty)
                              ? item['plot_per_floor'].toString()
                              : 'N/A',
                          style: TextStyle(
                              fontSize: (screenWidth <= 600) ? 12 : 14),
                        ),
                      )),
                      DataCell(Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit,
                                    size: screenWidth <= 600 ? 12 : 18,
                                    color: Colors.blue),
                                onPressed: () {},
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                icon: Icon(Icons.delete,
                                    size: screenWidth <= 600 ? 12 : 18,
                                    color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                            title: Text('Alert'),
                                            children: [
                                              Padding(
                                                child: Text(
                                                    'Are you sure to delete?'),
                                                padding: EdgeInsets.all(20.0),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                // Aligns children to the end (right in LTR languages)
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        // Aligns buttons to the end of the row
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('No'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]);
                                      });
                                },
                              ),
                              Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                  })
                            ],
                          ))),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
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
      print(response.body.runtimeType);
      dynamic jsonResponse = json.decode(response.body);
      print(jsonResponse.runtimeType);
      List<dynamic> dataList = jsonResponse as List<dynamic>;
      print(dataList.runtimeType);

      print(dataList.runtimeType);
      print(response.body.runtimeType);
      setState(() {
        data = dataList;
        print(data);
      });
      print("Fetched data: $data");
    } catch (e) {
      print(data);
      print('Error fetching data: $e');
    }
  }
}
