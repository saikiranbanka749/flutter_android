import 'dart:core';

import 'package:allow_me/widgets/DialogueBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Network/NetworkInfo.dart';
import '../widgets/SnackBarWidget.dart';

class RequestingScreen extends StatefulWidget {
  String phone = '', community_name = '';

  RequestingScreen(String phone, String community_name) {
    this.phone = phone;
    this.community_name = community_name;
  }

  @override
  State<RequestingScreen> createState() {
    return _RequestingScreenState(phone, community_name);
  }
}

class _RequestingScreenState extends State<RequestingScreen> {
  String phone = '', community_name = '';

  _RequestingScreenState(phone, community_name) {
    this.phone = phone;
    this.community_name = community_name;
  }

  int selectedPosition = 1;
  DateTime? _setDateValue;
  DateTime? _setTimeValue, _setInTimeValue, _setOutTimeValue;

  TextEditingController nameController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController flatNumberController = TextEditingController();
  TextEditingController setDateValueController = TextEditingController();
  TextEditingController setTimeValueController = TextEditingController();
  TextEditingController setIntimeController = TextEditingController();
  TextEditingController setOutTimeController = TextEditingController();
  TextEditingController visitorContactNumberController =
      TextEditingController();
  TextEditingController visitorAdharCardNumberController =
      TextEditingController();
  TextEditingController teenantNumberController = TextEditingController();

  String apartment_name = '';

  @override
  void initState() {
    print(phone);
    super.initState();
    fetchData(phone);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Visitor Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Gender:"),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedPosition,
                          onChanged: (value) {
                            setState(() {
                              selectedPosition = value as int;
                            });
                          },
                        ),
                        Text('Male'),
                        Radio(
                          value: 2,
                          groupValue: selectedPosition,
                          onChanged: (value) {
                            setState(() {
                              selectedPosition = value as int;
                            });
                          },
                        ),
                        Text('Female'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: purposeController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Purpose of Visit",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: flatNumberController,
                        decoration: InputDecoration(
                          labelText: "Flat Number",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: teenantNumberController,
                        decoration: InputDecoration(
                          labelText: "Tenant Mobile Number",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: setDateValueController,
                        decoration: InputDecoration(
                          labelText: "Date",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _setDate(context),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: setTimeValueController,
                        decoration: InputDecoration(
                          labelText: "Time",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time),
                            onPressed: () => _setTime(context),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: setIntimeController,
                        decoration: InputDecoration(
                          labelText: "In Time",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time),
                            onPressed: () => _setTime(context, "InTime"),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: setOutTimeController,
                        decoration: InputDecoration(
                          labelText: "Out Time",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time),
                            onPressed: () => _setTime(context, "OutTime"),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: visitorContactNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: "Visitor Contact Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  maxLength: 12,
                  controller: visitorAdharCardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorMaxLines: 5,
                    labelText: "Visitor Aadhar Card Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: addVisitor,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _setDateValue) {
      setState(() {
        _setDateValue = picked;
        setDateValueController.text =
            "${picked.day}/${picked.month}/${picked.year}"; // Update the text field
      });
    }
  }

  Future<void> _setTime(BuildContext context, [String field = "time"]) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      String formattedTime = "${picked.hour}:${picked.minute}";
      if (field == "time") {
        setTimeValueController.text = formattedTime;
      } else if (field == "InTime") {
        setIntimeController.text = formattedTime;
      } else if (field == "OutTime") {
        setOutTimeController.text = formattedTime;
      }
    }
  }

  Future<void> fetchData(String phone_number) async {
    print(phone_number);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('kk:mm').format(now);
    try {
      String url = NetworkInfo.url2 + "t_visitors.php?phone=${phone_number}";
      final uri = Uri.parse(url);
      print("here $url");
      final response = await http.get(uri);
      print(response.statusCode);
      print(response.body);
      List data = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          flatNumberController.text = data[0]['flat_number'];
          teenantNumberController.text = data[0]['phone'];
          setDateValueController.text = formattedDate;
          setTimeValueController.text = formattedTime;
          community_name = data[0]['community_name'];
          apartment_name = data[0]['block_name'];
        });
      } else {
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addVisitor() async {
    String url = NetworkInfo.url2 + "visitor.php";
    final String name = nameController.text.trim();
    final int gender = selectedPosition;
    final String purpose = purposeController.text.trim();
    final String flatNumber = flatNumberController.text.trim();
    final String date = setDateValueController.text.trim();
    final String time = setTimeValueController.text.trim();
    final String inTime = setIntimeController.text.trim();
    final String outTime = setOutTimeController.text.trim();
    final String visitorContactNumber =
        visitorContactNumberController.text.trim();
    final String visitorAdharCardNumber =
        visitorAdharCardNumberController.text.trim();
    final String tenantMobileNumber = teenantNumberController.text.trim();

    if (name.isNotEmpty &&
        purpose.isNotEmpty &&
        flatNumber.isNotEmpty &&
        date.isNotEmpty &&
        time.isNotEmpty &&
        inTime.isNotEmpty &&
        outTime.isNotEmpty &&
        visitorContactNumber.isNotEmpty &&
        visitorAdharCardNumber.isNotEmpty &&
        tenantMobileNumber.isNotEmpty) {
      var body = {
        "name": name,
        "gender": gender == 1 ? "Male" : "Female",
        "purpose": purpose,
        "flat_number": flatNumber,
        "date_time": "$date $time",
        "inTime": inTime,
        "outTime": outTime,
        "visitorContactNumber": visitorContactNumber,
        "visitorAdarCardNumber": visitorAdharCardNumber,
        "teenantMobileNumber": tenantMobileNumber,
        "role": 'tenant',
        'community_name': community_name,
        'block_name': apartment_name,
        "teenantMobileNumber": phone
      };

      final uri = Uri.parse(url);
      print(uri);

      var response = await http.post(uri, body: jsonEncode(body));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomDialogBox.DialogBox(
            context, "Visitor added successfully", "success");
        //  SnackBarWidget.scaffoldMessage(context, "Visitor added", "success");
        setState(() {
          nameController.text = '';
          purposeController.text = '';
          setIntimeController.text = '';
          setOutTimeController.text = '';
          visitorAdharCardNumberController.text = '';
          visitorContactNumberController.text = '';
        });
      } else {
        SnackBarWidget.scaffoldMessage(
            context, "Visitor adding failed", "error");
      }
    }
  }
}
