import 'dart:convert';

import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/President/TenantsScreen.dart';
import 'package:allow_me/PresidentHomeScreen.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTenant extends StatefulWidget {
  final Map? todo;
  String block_name, president_phone_number;

  AddTenant(
      {super.key,
      this.todo,
      required this.block_name,
      required this.president_phone_number});

  @override
  State<AddTenant> createState() =>
      _AddTenantState(block_name, president_phone_number);
}

class _AddTenantState extends State<AddTenant> {
  String block_name = "", president_phone_number = "";
  bool isEdit = false;
  List<String> gender = ['Select Gender', 'Male', 'Female'];
  var selectedItem = 'Select Gender';
  TextEditingController name_Controller = TextEditingController();
  TextEditingController age_Controller = TextEditingController();
  TextEditingController phone_Controller = TextEditingController();
  TextEditingController alternate_phone_Controller = TextEditingController();
  TextEditingController owner_phone_Contoller = TextEditingController();

  _AddTenantState(String block_name, String president_phone_number) {
    this.block_name = block_name;
    this.president_phone_number = president_phone_number;
    print(block_name);
  }

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    print("this is our ${todo}");
    if (widget.todo != null) {
      isEdit = true;
      final name = todo!['name'];
      final age = todo!['age'];
      final phone = todo!['phone'];
      final alter_nate_phone = todo!['alternate_phone'];
      final owner_phone_number = todo!['owner_phone_number'];
      print(todo!['gender']);
      print(todo!['phone']);
      //   selectedItem = todo!['gender'];
      name_Controller.text = name;
      age_Controller.text = age;
      phone_Controller.text = phone;
      alternate_phone_Controller.text = alter_nate_phone;
      owner_phone_Contoller.text = owner_phone_number;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(block_name);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text('Add Tenants'),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Tenant name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
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
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    title: Text(
                      'Tenant age',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new TextField(
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
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                  DropdownButton<String>(
                    value: selectedItem,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedItem = value!;
                        print("${selectedItem}  ${value}");
                      });
                    },
                    elevation: 1,
                    items: gender.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: Text(
                      'Tenant phone number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new TextField(
                    controller: phone_Controller,
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
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    title: Text(
                      'Altenate phone number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new TextField(
                    controller: alternate_phone_Controller,
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
                        "Alternate Phone Numeber",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    title: Text(
                      'Owner phone',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new TextField(
                    controller: owner_phone_Contoller,
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
                        "Owner Phone Number",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                      onPressed: isEdit ? updateTenant : addTenant,
                      child: Text(isEdit ? 'Update' : 'Add Tenant')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addTenant() async {
    print("addd tenant ${block_name}");
    final name = name_Controller.text;
    final age = age_Controller.text;
    final gender = selectedItem.toString();
    final phone = phone_Controller.text;
    final alternate_phone = alternate_phone_Controller.text;
    final owner_phone = owner_phone_Contoller.text;

    final body = {
      "name": name,
      "age": age,
      "gender": gender,
      "phone": phone,
      "alternate_phone": alternate_phone,
      "owner_phone": owner_phone,
      "block_name": block_name,
      "role": "tenant",
      // "flat_number":flat_number
    };
    if ((name != null && name.isNotEmpty) &&
        (phone != null && phone.isNotEmpty) &&
        (age != null && age.isNotEmpty) &&
        (gender != null && gender.isNotEmpty && gender != "Select Gender") &&
        (alternate_phone != null && alternate_phone.isNotEmpty) &&
        (owner_phone != null && owner_phone.isNotEmpty)) {
      print(
          "${name}       ${phone}       ${age}          here${gender}           ${alternate_phone}       ${owner_phone}");
      final url = NetworkInfo.url2 + "/tenant.php";
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('Creation Success');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PresidentHomeScreen(
                    "Home", president_phone_number, block_name)));
        SnackBarWidget.scaffoldMessage(
            context, 'Added Successfully', "success");
      } else if (response.statusCode == 404) {
        print("here ${response.statusCode}");
        SnackBarWidget.scaffoldMessage(context, "Owner doesn't exist", "error");
      } else {
        SnackBarWidget.scaffoldMessage(context, "Creation failed", "error");
      }
    } else {
      print("please enter all the fieds");
      scaffoldMessage(context, "Fill the data", "error");
    }
  }

  Future<void> updateTenant() async {
    final todo = widget.todo;

    final name = name_Controller.text;
    final age = age_Controller.text;
    final gender = selectedItem.toString();
    final phone = phone_Controller.text;
    final alternate_phone = alternate_phone_Controller.text;
    final created_date = todo!['created_date'];
    final tenant_id = todo!['tenant_id'];
    final owner_id = todo!['owner_id'];
    final owner_phone = owner_phone_Contoller.text;
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
      "block_name": block_name
    };

    if (name != null &&
        name.isNotEmpty &&
        phone != null &&
        phone.isNotEmpty &&
        age != null &&
        age.isNotEmpty &&
        gender != null &&
        gender.isNotEmpty &&
        gender != "Select Gender" &&
        alternate_phone != null &&
        alternate_phone.isNotEmpty &&
        owner_phone != null &&
        owner_phone.isNotEmpty) {
      final url = NetworkInfo.url2 + "/owner.php";

      final uri = Uri.parse(url);
      final response = await http.put(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      print(response.body);
      if (response.statusCode == 200) {
        print('Creation Success');
        SnackBarWidget.scaffoldMessage(
            context, 'Updated Successfully', "success");
        Navigator.of(context).pop();
      } else {
        SnackBarWidget.scaffoldMessage(
            context, "Updation failed failed", "error");
        print(response.body);
        print(response.statusCode);
      }
    } else {
      scaffoldMessage(context, "Please fill all the fields", "error");
    }
  }

  void scaffoldMessage(BuildContext context, String msg, String status) {
    print("scaffold");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Action',
          onPressed: () {
            // Code to execute.
          },
        ),
        backgroundColor: (status == "success") ? Colors.green : Colors.red,
        content: Row(
          children: <Widget>[
            // add your preferred icon here
            Icon(
              (status == "success") ? Icons.check_circle : Icons.dangerous,
              color: (status == "success" ? Colors.white : Colors.white),
            ),
            // add your preferred text content here
            Text(
              "  ${msg}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),

        duration: const Duration(milliseconds: 5000),
        width: 400.0,
        // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
