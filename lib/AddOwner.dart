import 'package:allow_me/widgets/DialogueBox.dart';
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
  final String community_name;
  final String president_phone_number;
  List<String> apartmentList = [];
  List<String> flat_numbers_List = [];
  String _selectedItem = 'Select Apartment/Block';
  String _selectFlatNumber = 'Select Flat';
  bool isEdit = false;
  final String url = NetworkInfo.url2 + "/owner.php";
  final TextEditingController name_Controller = TextEditingController();
  final TextEditingController flat_Controller = TextEditingController();
  final TextEditingController age_Controller = TextEditingController();
  final TextEditingController phone_Controller = TextEditingController();
  final TextEditingController alt_phone_Controller = TextEditingController();
  bool? _isChecked = false;
  int selectedPosition = 1;

  _AddOwnerState(this.community_name, this.president_phone_number);

  @override
  void initState() {
    super.initState();

    fetchApartments().then((_) {
      if (widget.todo != null) {
        isEdit = true;
        final todo = widget.todo!;
        final name = todo['name'];
        final flatNumber = todo['flat_number'];
        final age = todo['age'];
        final gender = todo['gender'];
        final phone = todo['phone'];
        final alt_phone = todo['alternate_phone'];

        name_Controller.text = name;
        flat_Controller.text = flatNumber;
        age_Controller.text = age;
        selectedPosition = int.parse(gender);
        phone_Controller.text = phone;
        alt_phone_Controller.text = alt_phone;

        if (todo['block_name'] != null &&
            apartmentList.contains(todo['block_name'])) {
          setState(() {
            _selectedItem = todo['block_name'];
            fetchFlatNumber(_selectedItem).then((_) {
              if (!flat_numbers_List.contains(flatNumber)) {
                flat_numbers_List.add(flatNumber);
              }
              setState(() {
                _selectFlatNumber = flatNumber;
              });
            });
          });
        }
      } else {
        if (apartmentList.isNotEmpty) {
          setState(() {
            _selectedItem = apartmentList[0];
          });
          fetchFlatNumber(_selectedItem).then((_) {
            if (flat_numbers_List.isNotEmpty) {
              setState(() {
                _selectFlatNumber = flat_numbers_List[0];
              });
            } else {
              setState(() {
                _selectFlatNumber = 'Select Flat';
              });
            }
          });
        }
      }
    });
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
                    value: apartmentList.isNotEmpty ? _selectedItem : null,
                    underline: SizedBox(),
                    items: apartmentList.map((String value) {
                      return DropdownMenuItem<String>(
                        enabled: !isEdit,
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: !isEdit
                        ? ((newValue) {
                            print(!isEdit);
                            setState(() {
                              _selectedItem = newValue!;
                              fetchFlatNumber(_selectedItem);
                            });
                          })
                        : null,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.blueAccent, width: 2.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: flat_numbers_List.contains(_selectFlatNumber)
                        ? _selectFlatNumber
                        : null,
                    underline: SizedBox(),
                    items: flat_numbers_List.isNotEmpty
                        ? flat_numbers_List.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : [
                            DropdownMenuItem<String>(
                              enabled: !isEdit,
                              value: 'Select Flat',
                              child: Text('Select Flat'),
                            ),
                          ],
                    onChanged: !isEdit
                        ? (newValue) {
                            setState(() {
                              _selectFlatNumber = newValue!;
                            });
                          }
                        : null, // Disable dropdown when isEdit is false
                  ),
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: TextField(
                  maxLength: 2,
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
          SizedBox(height: 20),
          CheckboxListTile(
            title: Text(
              'Add in tenant',
            ),
            enabled: isEdit ? false : true,
            value: _isChecked,
            onChanged: (bool? newValue) {
              setState(() {
                _isChecked = newValue;
              });
            },
            activeColor: Colors.orangeAccent,
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
            // tristate: true,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              isEdit ? updateOwner() : addOwner();
            },
            child: Text(isEdit ? "Update" : "Save"),
          ),
        ],
      ),
    );
  }

  Future<void> updateOwner() async {
    final todo = widget.todo!;
    final id = todo['owner_id'];
    final created_date = todo['created_date'];
    final String name = name_Controller.text;
    final String flatNo = _selectFlatNumber.toString();
    final String age = age_Controller.text;
    final int gender = selectedPosition;
    final String phone = phone_Controller.text;
    final String altPhone = alt_phone_Controller.text;

    print(flatNo);
    try {
      final response = await http.put(
        Uri.parse(url),
        body: {
          "id": id,
          "name": name,
          "flat_number": flatNo,
          "age": age,
          "gender": gender.toString(),
          "phone": phone,
          "alternate_phone": altPhone,
          "created_date": created_date,
          "block_name": _selectedItem,
          'community_name': community_name
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        CustomDialogBox.DialogBox(context, "Updated Successfully", "Success");
        SnackBarWidget.scaffoldMessage(
            context, "Updated Successfully", "success");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PresidentHomeScreen(
                "President", president_phone_number, community_name),
          ),
        );
      } else if (response.statusCode == 401) {
        SnackBarWidget.scaffoldMessage(
            context, "Sorry, phone number cant be update", "error");
      } else if (response.statusCode == 500) {
        SnackBarWidget.scaffoldMessage(
            context, "Phone number cant update", "error");
      } else if (response.statusCode == 503) {
        SnackBarWidget.scaffoldMessage(
            context, "Please try after some time", "error");
      } else {
        SnackBarWidget.scaffoldMessage(
            context, "User updation failed", "error");
      }
    } catch (e) {
      SnackBarWidget.scaffoldMessage(context, "Failed to update", "error");
    }
  }

  Future<void> addOwner() async {
    final String name = name_Controller.text;
    final String flatNo = _selectFlatNumber;
    final String age = age_Controller.text;
    final int gender = selectedPosition;
    final String phone = phone_Controller.text;
    final String altPhone = alt_phone_Controller.text;
    final String apartment_name = _selectedItem;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "name": name,
          "flat_number": flatNo,
          "age": age,
          "role": "owner",
          "gender": gender.toString(),
          "phone": phone,
          "alternate_phone": altPhone,
          "apartment_name": apartment_name,
          "community_name": community_name
        },
      );
      print("owner ${response.statusCode}");
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        // CustomDialogBox.DialogBox(
        //     context, "Owner updated successfully", "Success");
        SnackBarWidget.scaffoldMessage(
            context, "Owner added successfully", "success");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PresidentHomeScreen(
                "President", president_phone_number, community_name),
          ),
        );
      } else if (response.statusCode == 503) {
        CustomDialogBox.DialogBox(
            context, "Please try after some time", "info");
        // SnackBarWidget.scaffoldMessage(
        //     context, "Please try after some time", "error");
      } else {
        CustomDialogBox.DialogBox(context, "Fill all the fields", "warning");
        //  SnackBarWidget.scaffoldMessage(context, "User Adding Failed", "error");
      }
    } catch (e) {
      print(e);
      SnackBarWidget.scaffoldMessage(context, "Failed to add owner", "error");
    }
    if (_isChecked == true) {
      print("$name $flatNo $age $gender $phone $altPhone   $apartment_name");
      print(_isChecked);
      try {
        final response = await http.post(
          Uri.parse(NetworkInfo.url2 + "/tenant.php"),
          body: jsonEncode({
            "name": name,
            "age": age,
            "gender": gender.toString(),
            "phone": phone,
            "alternate_phone": altPhone,
            "owner_phone": phone,
            "community_name": community_name,
            "block_name": _selectedItem.toString(),
            "role": "tenant",
            "flat_number": _selectFlatNumber.toString(),
          }),
        );
        print("tenant  ${response.statusCode}");
        print(response.body);
        if (response.statusCode != 200) {
          print("Failed to add tenant: ${response.body}");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> fetchApartments() async {
    final url = NetworkInfo.url2 + "/owner.php?community_name=$community_name";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          apartmentList = data
              .map<String>((item) => item['apartment_name'].toString())
              .toList();
          if (apartmentList.isNotEmpty && !isEdit) {
            apartmentList.insert(0, "Select Apartment/Block");
            _selectedItem = apartmentList[0];
            fetchFlatNumber(
                _selectedItem); // Fetch flat numbers for the default apartment
          } else if (isEdit) {
            _selectedItem = apartmentList.contains(_selectedItem)
                ? _selectedItem
                : 'Select Apartment/Block';
          }
        });
      } else {
        print("Failed to fetch apartments: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching apartments: $e");
    }
  }

  Future<void> fetchFlatNumber(String selectedItem) async {
    final url = NetworkInfo.url2 +
        "/flats.php?community_name=$community_name&selectedblock=$selectedItem&screen=owner";
    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      print(url);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> availableFlatsDynamic = data['available_flats'];
        List<String> availableFlats =
            availableFlatsDynamic.map((item) => item.toString()).toList();

        setState(() {
          flat_numbers_List = availableFlats;
          if (flat_numbers_List.isNotEmpty) {
            if (isEdit) {
              if (!flat_numbers_List.contains(_selectFlatNumber)) {
                _selectFlatNumber = 'Select Flat';
              }
            } else {
              flat_numbers_List.insert(0, "Select Flat");
              _selectFlatNumber = flat_numbers_List[0];
            }
          } else {
            _selectFlatNumber = 'Select Flat';
          }
        });
      } else {
        print("Failed to fetch flats: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching flats: $e");
    }
  }
}
