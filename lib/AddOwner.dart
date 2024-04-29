import 'dart:convert';
import 'dart:io';

import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PresidentHomeScreen.dart';

class AddOwner extends StatefulWidget {
  final Map? todo;
  String? block_name, president_phone;

  AddOwner({Key? key, this.todo, this.block_name, this.president_phone})
      : super(key: key) {
    // Printing the values in the constructor
    print('Todo: $todo');
    print('Block Name: $block_name');
    print('President Phone: $president_phone');
  }

  @override
  State<AddOwner> createState() =>
      _AddOwnerState(block_name!, president_phone!);
}

class _AddOwnerState extends State<AddOwner> {
  String block_name, president_phone_number;

  _AddOwnerState(this.block_name, this.president_phone_number);

  bool isEdit = false;
  String url = "http://192.168.2.142/allowMe/owner.php";
  TextEditingController name_Controller = TextEditingController();
  TextEditingController flat_Controller = TextEditingController();
  TextEditingController age_Controller = TextEditingController();

//  TextEditingController gender_Controller = TextEditingController();
  TextEditingController phone_Controller = TextEditingController();
  TextEditingController alt_phone_Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    print("here ${todo}");
    if (widget.todo != null) {
      isEdit = true;
      final name = todo!['name'];
      final flotNumber = todo!['flat_number'];
      final age = todo!['age'];
      final gender = todo!['gender'];
      final phone = todo!['phone'];
      final alt_phone = todo!['alternate_phone'];
      final id = todo!['id'];
      name_Controller.text = name;
      flat_Controller.text = flotNumber;
      age_Controller.text = age;
      selectedPosition = int.parse(gender);
      phone_Controller.text = phone;
      alt_phone_Controller.text = alt_phone;
    }
  }

  int selectedPosition = 1;

  @override
  Widget build(BuildContext context) {
    print("ME ${block_name} $president_phone_number");
    return Scaffold(
        appBar: AppBar(
          title: Text('Allow me'),
        ),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(
              controller: name_Controller,
              decoration: InputDecoration(hintText: 'OwnerName'),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: flat_Controller,
              decoration: InputDecoration(hintText: 'Flat Number'),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: age_Controller,
              decoration: InputDecoration(hintText: 'Age Number'),
            ),
            SizedBox(
              height: 40,
            ),
            RadioListTile(
                value: 1,
                groupValue: selectedPosition,
                onChanged: (value) {
                  setState(() {
                    selectedPosition = int.parse(value.toString());
                  });
                },
                title: Text('Fe Male')),
            RadioListTile(
                value: 2,
                groupValue: selectedPosition,
                onChanged: (value) {
                  setState(() {
                    selectedPosition = int.parse(value.toString());
                  });
                },
                title: Text('Male')),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: phone_Controller,
              decoration: InputDecoration(hintText: 'Phone'),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: alt_phone_Controller,
              decoration: InputDecoration(hintText: 'Alternate Phone Number'),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: isEdit ? updateOwner : addOwner,
                child: Text(
                  (isEdit ? "Update" : "Save"),
                ))
          ],
        ));
  }

  Future<void> updateOwner() async {
    final todo = widget.todo;

    final id = todo!['owner_id'];
    final created_date = todo!['created_date'];
    final String name = name_Controller.text;
    final String flotNo = flat_Controller.text;
    final String age = age_Controller.text.toString();
    final int gender = selectedPosition;
    final String phone = phone_Controller.text.toString();
    final String altPhone = alt_phone_Controller.text.toString();
    String url = "http://192.168.2.142/allowMe/owner.php";
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
        },
      );
      print(response.statusCode);
      String rBody = response.body;
      print(rBody);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        SnackBarWidget.scaffoldMessage(
            context, "Updated Succesfully", "success");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PresidentHomeScreen(
                    "President", president_phone_number, "")));
      } else if (response.statusCode == 503) {
        SnackBarWidget.scaffoldMessage(
            context, "Please try after some time", "error");
      } else {
        SnackBarWidget.scaffoldMessage(context, "UserAdding failed", "error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addOwner() async {
    final String name = name_Controller.text;
    final String flotNo = flat_Controller.text;
    final String age = age_Controller.text.toString();
    final int gender = selectedPosition;
    final String phone = phone_Controller.text.toString();
    final String altPhone = alt_phone_Controller.text.toString();
    print(
        "name: ${name} ${name.runtimeType}  flotno:  ${flotNo} ${flotNo.runtimeType}  age: ${age}  ${age.runtimeType} "
        ""
        " gender:  ${gender}  ${gender.runtimeType}  phone ${phone}${phone.runtimeType}   ${altPhone}    ${altPhone.runtimeType} ");

    String url = NetworkInfo.url2 + "/owner.php";
    print(block_name);
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
          "block_name": block_name
        },
      );
      print(response.statusCode);
      print(response.body);
      //print(r);
      if (response.statusCode == 201) {
        SnackBarWidget.scaffoldMessage(
            context, "Owner added successfully", "success");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PresidentHomeScreen(
                    "President", president_phone_number, block_name)));
      } else if (response.statusCode == 409) {
        SnackBarWidget.scaffoldMessage(
            context, "Flat already alloted in this block", "error");
      } else if (response.statusCode == 503) {
        SnackBarWidget.scaffoldMessage(
            context, "Please try after some time", "error");
      } else {
        SnackBarWidget.scaffoldMessage(context, "UserAdding Failed", "error");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
