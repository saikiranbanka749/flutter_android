import 'package:allow_me/HomeScreen.dart';
import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/PresidentHomeScreen.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddApartment extends StatefulWidget {
  String title, president_phone, communityname;

  AddApartment(this.title, this.president_phone, this.communityname);

  @override
  State<StatefulWidget> createState() =>
      _AddApartmentState(title, president_phone, communityname);
}

class _AddApartmentState extends State<AddApartment> {
  String title, president_phone, communityname;

  _AddApartmentState(this.title, this.president_phone, this.communityname);

  TextEditingController apartmentName_controller = TextEditingController();
  TextEditingController communityName_controller = TextEditingController();
  TextEditingController no_of_flats_controller = TextEditingController();
  TextEditingController no_of_floors_controller = TextEditingController();
  TextEditingController flats_per_floor_controller = TextEditingController();
  TextEditingController sold_flats_controller = TextEditingController();
  TextEditingController unSold_flats_controller = TextEditingController();
  TextEditingController booked_flats_controller = TextEditingController();
  List<String> FlotType = <String>['Flot Type', '2BHK', '3 BHK'];
  var _selectedItem;
  List<String> Furnished = <String>['Furnished', 'Unfurnished'];
  var _selectedItem2;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    print("the apartment name is $communityname");
    super.initState();
    _selectedItem = FlotType.first;
    _selectedItem2 = Furnished.first;
    // List<String> words = communityname.split(' ');
    // words.removeAt(0);
    // print(words);
    // String result = words.join(' ');
    communityName_controller.text = communityname;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Apartment'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_backspace),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Container(
            width: (screenWidth >= 600) ? screenWidth * 0.8 : screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: apartmentName_controller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Apartment name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    // Optional spacing between text fields
                    Expanded(
                      child: TextField(
                        controller: communityName_controller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Community name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: no_of_flats_controller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "No. of plots",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    // Optional spacing between text fields
                    Expanded(
                      child: TextField(
                        controller: no_of_floors_controller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "No. of floors",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    // Optional spacing between text fields
                    Expanded(
                      child: TextField(
                        controller: flats_per_floor_controller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Flat per floor",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Row(
                //   children: [
                //     Expanded(
                //       child: TextField(
                //         controller: sold_flats,
                //         keyboardType: TextInputType.phone,
                //         decoration: InputDecoration(
                //           labelText: "Sold Flats",
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(15.0),
                //             borderSide:
                //                 BorderSide(color: Colors.blueAccent, width: 2.0),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20.0),
                //             borderSide: BorderSide(color: Colors.blueAccent),
                //           ),
                //           labelStyle:
                //               TextStyle(color: Colors.blueAccent, fontSize: 20),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 20), // Optional spacing between text fields
                //     Expanded(
                //       child: TextField(
                //         controller: unSold_flats,
                //         keyboardType: TextInputType.phone,
                //         decoration: InputDecoration(
                //           labelText: "Unsold Flats",
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(15.0),
                //             borderSide:
                //                 BorderSide(color: Colors.blueAccent, width: 2.0),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20.0),
                //             borderSide: BorderSide(color: Colors.blueAccent),
                //           ),
                //           labelStyle:
                //               TextStyle(color: Colors.blueAccent, fontSize: 20),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 20), // Optional spacing between text fields
                //     Expanded(
                //       child: TextField(
                //         controller: booked_flats,
                //         keyboardType: TextInputType.phone,
                //         decoration: InputDecoration(
                //           labelText: "Booked flats",
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(15.0),
                //             borderSide:
                //                 BorderSide(color: Colors.blueAccent, width: 2.0),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20.0),
                //             borderSide: BorderSide(color: Colors.blueAccent),
                //           ),
                //           labelStyle:
                //               TextStyle(color: Colors.blueAccent, fontSize: 20),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 20),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(15.0),
                //           border: Border.all(color: Colors.blueAccent, width: 2.0),
                //         ),
                //         padding: EdgeInsets.symmetric(horizontal: 12.0),
                //         child: DropdownButton<String>(
                //           isExpanded: true,
                //           value: _selectedItem,
                //           underline: SizedBox(),
                //           items: FlotType.map((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //           onChanged: (newValue) {
                //             setState(() {
                //               _selectedItem = newValue!;
                //             });
                //           },
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Expanded(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(15.0),
                //           border: Border.all(color: Colors.blueAccent, width: 2.0),
                //         ),
                //         padding: EdgeInsets.symmetric(horizontal: 12.0),
                //         child: DropdownButton<String>(
                //           isExpanded: true,
                //           value: _selectedItem2,
                //           underline: SizedBox(),
                //           items: Furnished.map((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //           onChanged: (newValue) {
                //             setState(() {
                //               _selectedItem2 = newValue!;
                //             });
                //           },
                //         ),
                //       ),
                //     ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: addApartmentsTodo,
                  child: Text('Add Apartment'),
                ),
              ],
            ),
          ))),
    );
  }

  Future<void> addApartmentsTodo() async {
    final apartment_name = apartmentName_controller.text.toString();
    final community_name = communityName_controller.text.toString();
    final noOfFlats = no_of_flats_controller.text.toString();
    final noOfFloors = no_of_floors_controller.text.toString();
    final flatsPerFloor = flats_per_floor_controller.text.toString();
    // final soldFats = sold_flats.text.toString();
    // final unSoldFlats = unSold_flats.text.toString();
    // final bookedFlats = booked_flats.text.toString();
    // final flatType = _selectedItem.toString();
    // final furnishedType = _selectedItem2.toString();

    if (int.parse(noOfFlats) ==
        int.parse(noOfFloors) * int.parse(flatsPerFloor)) {
      final url = NetworkInfo.url2 + "addApartment.php";
      final body = {
        "apartment_name": apartment_name,
        "community_name": community_name,
        "noOfFlats": noOfFlats,
        "noOfFloors": noOfFloors,
        "flatsPerFloor": flatsPerFloor,
        // "soldFats": soldFats,
        // "unSoldFlats": unSoldFlats,
        // "bookedFlats": bookedFlats,
        // "flatType": flatType,
        // "furnishedType": furnishedType
      };
      final uri = Uri.parse(url);
      print(uri);
      var response = await http.post(uri, body: jsonEncode(body));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode <= 203) {
        SnackBarWidget.scaffoldMessage(
            context, 'Added Successfully', "success");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PresidentHomeScreen(
                    title, president_phone, communityname)));
      }
    } else {
      SnackBarWidget.scaffoldMessage(
          context, 'Data miss match with number of flats', "error");
    }
  }
}
