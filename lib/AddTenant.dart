import 'dart:convert';

import 'package:allow_me/AddOwner.dart';
import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/OwnersHomeScreen.dart';
import 'package:allow_me/President/TenantsScreen.dart';
import 'package:allow_me/PresidentHomeScreen.dart';
import 'package:allow_me/widgets/DialogueBox.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTenant extends StatefulWidget {
  final Map? todo;
  String role, president_phone_number, community_name;

  AddTenant(
      {super.key,
      this.todo,
      required this.role,
      required this.president_phone_number,
      required this.community_name});

  @override
  State<AddTenant> createState() => AddTenantState(
        role,
        president_phone_number,
        community_name,
      );
}

class AddTenantState extends State<AddTenant> {
  final _formKey = GlobalKey<FormState>();
  String community_name = "", president_phone_number = "", role = '';
  bool isEdit = false;
  String _selectFlatNumber = 'Select flat number';
  List<String> flat_numbers_List = [];
  List<String> apartmentList = [];
  String _selectedItem = 'Select Apartment/Block';
  TextEditingController name_Controller = TextEditingController();
  TextEditingController age_Controller = TextEditingController();
  TextEditingController phone_Controller = TextEditingController();
  TextEditingController alternate_phone_Controller = TextEditingController();
  TextEditingController owner_phone_Contoller = TextEditingController();
  TextEditingController flat_number_controller = TextEditingController();
  bool isTextFieldEnabled = false;

  AddTenantState(
      String role, String president_phone_number, String community_name) {
    this.role = role;
    this.community_name = community_name;
    this.president_phone_number = president_phone_number;
    print(community_name);
  }

  @override
  void initState() {
    print(
        "role: $role,    community_name     $community_name $president_phone_number");
    super.initState();
    AddOwner a = new AddOwner();

    fetchApartments(community_name);
    fetchFlatNumber(_selectedItem);
    final todo = widget.todo;
    if (role != 'AssociationPresident' &&
        role != 'President' &&
        role != 'president') {
      print("jhghgjhjh ${role}");
      owner_phone_Contoller.text = president_phone_number;
    }
    print("this is our ${todo}");
    if (widget.todo != null) {
      isEdit = true;
      final name = todo!['name'];
      final age = todo!['age'];
      final phone = todo!['phone'];
      final block_name = todo!['block_name'];
      final alter_nate_phone = todo!['alternate_phone'];
      final owner_phone_number = todo!['owner_phone_number'];
      final gender = todo!['gender'];
      final flat_number = todo!['flat_number'];
      name_Controller.text = name;
      age_Controller.text = age;
      flat_number_controller.text = flat_number;
      //   _selectedItem = block_name;
      selectedPosition = int.parse(gender);
      phone_Controller.text = phone;
      print("this is the owner phone number ${owner_phone_number} \n\n\n\n");
      alternate_phone_Controller.text = alter_nate_phone;
      // if (role != 'Association President' &&
      //     role != 'President' &&
      //     role != "president" &&
      //     role != 'AssociationPresident') {
      owner_phone_Contoller.text = owner_phone_number;
      fetchApartments(community_name);

      if (todo['block_name'] != null &&
          apartmentList.contains(todo['block_name'])) {
        setState(() {
          _selectedItem = todo['block_name'];
          fetchFlatNumber(_selectedItem).then((_) {
            if (!flat_numbers_List.contains(flat_number)) {
              flat_numbers_List.add(flat_number);
              print("in if condtion");
              print(flat_number);
              print(flat_numbers_List);
            }
            setState(() {
              _selectFlatNumber = flat_number;
            });
          });
        });
      } else {
        fetchApartments(block_name);
        fetchFlatNumber(_selectedItem).then((_) {
          if (!flat_numbers_List.contains(flat_number)) {
            flat_numbers_List.add(flat_number);
          }
          setState(() {
            _selectFlatNumber = flat_number;
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

    print("fetch $community_name blocks");
  }

  int selectedPosition = 1;

  @override
  Widget build(BuildContext context) {
    print(community_name);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text(isEdit ? 'Update Tenant' : 'Add Tenants'),
            leading: isEdit
                ? null
                : IconButton(
                    icon: Icon(Icons.keyboard_backspace_outlined),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            Container(
                child: Form(
              key: _formKey,
              child: Column(
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
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            label: Text(
                              "Enter tenat Name",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: TextFormField(
                          maxLength: 2,
                          controller: age_Controller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            label: Text(
                              "Enter tenant age",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    title: Text(
                      'Select Gender',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: RadioListTile(
                          value: 1,
                          groupValue: selectedPosition,
                          onChanged: (value) {
                            setState(() {
                              selectedPosition = int.parse(value.toString());
                            });
                          },
                          title: Text(
                            'Male',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RadioListTile(
                          value: 2,
                          groupValue: selectedPosition,
                          onChanged: (value) {
                            setState(() {
                              selectedPosition = int.parse(value.toString());
                            });
                          },
                          title: Text(
                            'Female',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: new TextField(
                            enabled: isEdit ? false : true,
                            controller: owner_phone_Contoller,
                            maxLength: 10,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                                // Set this to match enabledBorder
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.blueAccent)),
                              label: Text(
                                "Owner Phone Number",
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 20),
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: new TextField(
                          controller: phone_Controller,
                          maxLength: 10,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            label: Text(
                              "Phone Number",
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: new TextFormField(
                          controller: alternate_phone_Controller,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  const BorderSide(color: Colors.blueAccent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            label: Text(
                              "Alternate Phone Number",
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alternate phone number is required';
                            } else if (value.length != 10) {
                              return 'Alternate phone number must be exactly 10 digits';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2.0),
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
                              print(_selectedItem);
                            });
                            fetchFlatNumber(_selectedItem);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2.0),
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
                                  DropdownMenuItem(
                                      value: 'Select Flat',
                                      child: Text('Select Flat'))
                                ],
                          onChanged: (newValue) {
                            setState(() {
                              _selectFlatNumber = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 60),
                  ElevatedButton(
                      onPressed: isEdit ? updateTenant : addTenant,
                      child: Text(isEdit ? 'Update' : 'Add Tenant')),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> addTenant() async {
    print(role);
    print("addd tenant ${community_name}");
    final name = name_Controller.text;
    final flat_num = flat_number_controller.text;
    final age = age_Controller.text;
    final int gender = selectedPosition;
    final phone = phone_Controller.text;
    final alternate_phone = alternate_phone_Controller.text;
    final owner_phone = owner_phone_Contoller.text;
    print(role);
    final body = {
      "name": name,
      "age": age,
      "gender": gender,
      "phone": phone,
      "alternate_phone": alternate_phone,
      "owner_phone": owner_phone,
      "community_name": community_name,
      "block_name": _selectedItem.toString(),
      "role": "tenant",
      "flat_number": _selectFlatNumber,
      "created_by": role,
      "updated_by": role,
    };
    if ((name != null && name.isNotEmpty) &&
        (phone != null && phone.isNotEmpty) &&
        (age != null && age.isNotEmpty) &&
        (alternate_phone != null && alternate_phone.isNotEmpty) &&
        (owner_phone != null && owner_phone.isNotEmpty)) {
      print(
          "${name}       ${phone}       ${age}       ${flat_num}   here${gender}           ${alternate_phone}       ${owner_phone}");
      final url = NetworkInfo.url2 + "/tenant.php";
      final uri = Uri.parse(url);
      print(url);
      final response = await http.post(uri, body: jsonEncode(body));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Creation Success');
        if (role != 'Owner') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PresidentHomeScreen(
                      role, president_phone_number, community_name)));
          SnackBarWidget.scaffoldMessage(
              context, 'Added Successfully', "success");
        } else if (role == 'Owner') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OwnerHomeScreen(
                      role, president_phone_number, community_name)));
          SnackBarWidget.scaffoldMessage(
              context, 'Added Successfully', "success");
        }
      } else if (response.statusCode == 404) {
        CustomDialogBox.DialogBox(context, "Owner doesn't exist", "info");
        print("here ${response.statusCode}");
      } else if (response.statusCode == 401) {
        CustomDialogBox.DialogBox(
            context, "$owner_phone is not belongs that flat number", "info");
      } else if (response.statusCode == 204) {
        SnackBarWidget.scaffoldMessage(
            context, "Please check the flat number/block name", "error");
      } else if (response.statusCode == 400) {
        SnackBarWidget.scaffoldMessage(
            context, "No owner existed with that number", "error");
      } else if (response.statusCode == 409) {
        CustomDialogBox.DialogBox(
            context, "Tenant number already exists", "info");
      } else {
        SnackBarWidget.scaffoldMessage(context, "Creation failed", "error");
      }
    } else {
      print("please enter all the fieds");
      SnackBarWidget.scaffoldMessage(context, "Fill the data", "error");
    }
  }

  Future<void> updateTenant() async {
    print("updte tenent $role    $president_phone_number     $community_name");
    final todo = widget.todo;
    print(community_name);
    final name = name_Controller.text;
    final age = age_Controller.text;
    final int gender = selectedPosition;
    final phone = phone_Controller.text;
    final alternate_phone = alternate_phone_Controller.text;
    final created_date = todo!['created_date'];
    final tenant_id = todo!['tenant_id'];
    final owner_id = todo!['owner_id'];
    final owner_phone = owner_phone_Contoller.text;
    final block_name = _selectedItem.toString();
    final body = {
      "name": name,
      "age": age,
      "gender": gender,
      "phone": phone,
      "tenant_id": tenant_id,
      "alternate_phone": alternate_phone,
      "created_date": created_date,
      "owner_id": owner_id,
      "role": "Tenant",
      "owner_phone_number": owner_phone,
      "community_name": community_name,
      "block_name": block_name,
      "updated_by": role
    };
    print(_selectedItem);
    print(block_name);
    if (name != null &&
        name.isNotEmpty &&
        phone != null &&
        phone.isNotEmpty &&
        age != null &&
        age.isNotEmpty &&
        gender != null &&
        alternate_phone != null &&
        alternate_phone.isNotEmpty &&
        owner_phone != null &&
        owner_phone.isNotEmpty) {
      final url = NetworkInfo.url2 + "tenant.php";
      final uri = Uri.parse(url);
      print(url);
      final response = await http.put(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      print(response.body);
      print(response.statusCode);
      try {
        if (response.statusCode == 200) {
          print('Updation Success');

          if (role != 'Owner') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PresidentHomeScreen(
                        role, president_phone_number, community_name)));
            SnackBarWidget.scaffoldMessage(
                context, 'Updated Successfully', "success");
          } else if (role == 'Owner') {
            print("navigating from tenant owner role to owner's screen");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OwnerHomeScreen(
                        role, president_phone_number, community_name)));
            SnackBarWidget.scaffoldMessage(
                context, 'Updated Successfully', "success");
          }
        } else {
          SnackBarWidget.scaffoldMessage(context, "Updation failed", "error");
          //   print(response.body);
          print("here");
          print(response.statusCode);
        }
      } catch (e) {
        print(e);
      }
    } else {
      SnackBarWidget.scaffoldMessage(
          context, "Please fill all the fields", "error");
      print("please enter fileds");
    }
  }

  Future<void> fetchApartments(String block_name) async {
    print("fetch apartments $block_name");
    String url = NetworkInfo.url2 + "/owner.php?community_name=$community_name";
    print("gere $url");
    try {
      http.Response response = await http.get(Uri.parse(url));
      print("the apartmtnet are ");
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          apartmentList =
              data.map<String>((item) => item['apartment_name']).toList();
          print(apartmentList);
          if (block_name.isEmpty) {
            print("apartments are $apartmentList");
            if (apartmentList.isNotEmpty) {
              apartmentList.insert(0, "Select Apartment");
              _selectedItem = apartmentList[0];
            }
          } else {
            apartmentList.insert(0, "Select Apartment");
            int index = apartmentList.indexOf(block_name);
            if (index != -1) {
              _selectedItem = apartmentList[index];
            } else {
              print("Block name not found in apartment list");
              // Handle the case where block_name is not found in the list
              if (apartmentList.isNotEmpty) {
                _selectedItem = apartmentList[0]; // or any default behavior
              }
            }
            print(_selectedItem);
            print(apartmentList);
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
        "/flats.php?community_name=$community_name&selectedblock=$selectedItem&screen=tenant";
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
