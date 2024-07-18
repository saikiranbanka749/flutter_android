import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PresidentHomeScreen.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:allow_me/Network/NetworkInfo.dart';

class AddOwner extends StatefulWidget {
  final Map<dynamic, dynamic>? todo;
  final String? community_name, president_phone;

  AddOwner({Key? key, this.todo, this.community_name, this.president_phone})
      : super(key: key);

  @override
  State<AddOwner> createState() =>
      _AddOwnerState(community_name ?? '', president_phone ?? '');
}

class _AddOwnerState extends State<AddOwner> {
  String community_name, president_phone_number;
  List<String> apartmentList = [];
  String _selectedItem = 'Select Apartment/Block';
  bool isEdit = false;
  String url = NetworkInfo.url2 + "/owner.php";
  TextEditingController name_Controller = TextEditingController();
  TextEditingController flat_Controller = TextEditingController();
  TextEditingController age_Controller = TextEditingController();
  TextEditingController phone_Controller = TextEditingController();
  TextEditingController alt_phone_Controller = TextEditingController();

  int selectedPosition = 1;

  _AddOwnerState(this.community_name, this.president_phone_number);

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      isEdit = true;
      final todo = widget.todo!;
      final name = todo['name'];
      final flotNumber = todo['flat_number'];
      final age = todo['age'];
      final gender = todo['gender'];
      final phone = todo['phone'];
      final alt_phone = todo['alternate_phone'];
      print("hereregerregergerg ${todo!['block_name']}");
      name_Controller.text = name;
      flat_Controller.text = flotNumber;
      age_Controller.text = age;
      _selectedItem = todo!['block_name'];
      selectedPosition = int.parse(gender);
      phone_Controller.text = phone;
      alt_phone_Controller.text = alt_phone;
      fetchApartments(_selectedItem.toString());
    } else {
      fetchApartments('');
    }
    //   fetchApartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allow me'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          SizedBox(height: 80),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: name_Controller,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                    labelText: "Owner Name",
                    labelStyle: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.blueAccent, width: 2.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedItem,
                    underline: SizedBox(),
                    items: apartmentList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: flat_Controller,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                    labelText: "Flat Number",
                    labelStyle: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: TextField(
                  controller: age_Controller,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                    labelText: "Age",
                    labelStyle: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  value: 1,
                  groupValue: selectedPosition,
                  onChanged: (value) {
                    setState(() {
                      selectedPosition = int.parse(value.toString());
                    });
                  },
                  title: Text('Male'),
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: 2,
                  groupValue: selectedPosition,
                  onChanged: (value) {
                    setState(() {
                      selectedPosition = int.parse(value.toString());
                    });
                  },
                  title: Text('Female'),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          TextField(
            controller: phone_Controller,
            maxLength: 10,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.blueAccent),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.blueAccent),
              ),
              labelText: "Phone number",
              labelStyle: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 40),
          TextField(
            controller: alt_phone_Controller,
            maxLength: 10,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.blueAccent),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.blueAccent),
              ),
              labelText: "Alternate phone number",
              labelStyle: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: isEdit ? updateOwner : addOwner,
            child: Text(isEdit ? "Update" : "Save"),
          ),
        ],
      ),
    );
  }

  Future<void> updateOwner() async {
    print(community_name);
    final todo = widget.todo;
    final id = todo!['owner_id'];
    final created_date = todo['created_date'];
    final String name = name_Controller.text;
    final String flotNo = flat_Controller.text;
    final String age = age_Controller.text.toString();
    final int gender = selectedPosition;
    final String phone = phone_Controller.text.toString();
    final String altPhone = alt_phone_Controller.text.toString();
    print(url);
    try {
      http.Response response = await http.put(
        Uri.parse(url),
        body: {
          "id": id,
          "name": name,
          "flat_number": flotNo,
          "age": age,
          "gender": gender.toString(),
          "phone": phone,
          "alternate_phone": altPhone,
          "created_date": created_date,
          "block_name": _selectedItem.toString(),
          'community_name': community_name
        },
      );
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        SnackBarWidget.scaffoldMessage(
            context, "Updated Successfully", "success");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PresidentHomeScreen("President", president_phone_number, ""),
          ),
        );
      } else if (response.statusCode == 503) {
        SnackBarWidget.scaffoldMessage(
            context, "Please try after some time", "error");
      } else {
        SnackBarWidget.scaffoldMessage(context, "User Adding failed", "error");
      }
    } catch (e) {
      print(e.toString());
      SnackBarWidget.scaffoldMessage(context, "Failed to update", "error");
    }
  }

  Future<void> addOwner() async {
    final String name = name_Controller.text;
    final String flotNo = flat_Controller.text;
    final String age = age_Controller.text.toString();
    final int gender = selectedPosition;
    final String phone = phone_Controller.text.toString();
    final String altPhone = alt_phone_Controller.text.toString();
    final String apartment_name = _selectedItem.toString();
    String url = NetworkInfo.url2 + "/owner.php";

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: {
          "name": name,
          "flat_number": flotNo,
          "age": age,
          "role": "owner",
          "gender": gender.toString(),
          "phone": phone,
          "alternate_phone": altPhone,
          "apartment_name": apartment_name,
          "community_name": community_name
        },
      );
      print(response.body);
      if (response.statusCode == 201) {
        SnackBarWidget.scaffoldMessage(
            context, "Owner added successfully", "success");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PresidentHomeScreen(
                "President", president_phone_number, community_name),
          ),
        );
      } else if (response.statusCode == 409) {
        SnackBarWidget.scaffoldMessage(
            context, "Flat already allocatted in this block", "error");
      } else if (response.statusCode == 503) {
        SnackBarWidget.scaffoldMessage(
            context, "Please try after some time", "error");
      } else {
        SnackBarWidget.scaffoldMessage(context, "User Adding Failed", "error");
      }
    } catch (e) {
      print(e.toString());
      SnackBarWidget.scaffoldMessage(context, "Failed to add owner", "error");
    }
  }

  Future<void> fetchApartments(String block_name) async {
    print("called $block_name");
    String url = NetworkInfo.url2 + "/owner.php?community_name=$community_name";
    print(url);
    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          apartmentList =
              data.map<String>((item) => item['apartment_name']).toList();
          if (block_name.isEmpty) {
            print("apartments are $apartmentList");
            if (apartmentList.isNotEmpty) {
              _selectedItem = apartmentList[0];
            }
          } else {
            int index = apartmentList.indexOf(block_name);
            _selectedItem = apartmentList[index];
          }
        });
      } else {
        print("Failed to fetch apartments: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching apartments: $e");
    }
  }
}
