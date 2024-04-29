import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'PresidentHomeScreen.dart';

class AddSecurity extends StatefulWidget {
  final Map? todo;
  String president_phone, block_name;

  AddSecurity(
      {super.key,
      this.todo,
      required this.president_phone,
      required this.block_name}) {
    print('${president_phone}    ${block_name}');
  }

  @override
  State<AddSecurity> createState() =>
      _AddSecurityState(president_phone, block_name);
}

class _AddSecurityState extends State<AddSecurity> {
  String president_phone = "", block_name = "";
  bool isEdit = false;
  bool inputTextNotNull = false;
  DateTime? _serviceStartingDate;
  DateTime? _serviceEndingDate;
  bool status = false;
  bool isChecked_A = false;
  bool isChecked_B = false;
  bool isChecked_C = false;
  TextEditingController name_Controller = TextEditingController();
  TextEditingController age_Controller = TextEditingController();
  TextEditingController block_Controller = TextEditingController();
  TextEditingController address_Controller = TextEditingController();
  TextEditingController service_starting_Controller = TextEditingController();
  TextEditingController service_ending_Controller = TextEditingController();
  TextEditingController phoneNumber_controller = TextEditingController();
  TextEditingController alternatePhoneNumber_controller =
      TextEditingController();

  _AddSecurityState(String president_phone, String block_name) {
    this.president_phone = president_phone;
    this.block_name = block_name;
  }

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    print("here ${todo}");
    if (widget.todo != null) {
      name_Controller.text = todo!["name"];
      age_Controller.text = todo!['age'];
      block_Controller.text = todo!['block_name'];
      address_Controller.text = todo!['address'];
      print(todo!['service_end_date']);
      _serviceEndingDate = DateTime.parse(todo!['service_end_date']);
      _serviceStartingDate = DateTime.parse(todo!['service_start_date']);
      phoneNumber_controller.text = todo!['phone'];
      status = (todo!['active'] == '1') ? true : false;
      alternatePhoneNumber_controller.text = todo!['alternate_phone'];
      var shifts = todo!['shift'];
      if (shifts == "A") {
        isChecked_A = true;
      } else if (shifts == "B") {
        isChecked_B = true;
      } else if (shifts == "C") {
        isChecked_C = true;
      } else {
        List<String> shiftsArray = shifts.split(' ');
        print("${shiftsArray}   ${shiftsArray.length}");
        isChecked_A = shiftsArray[0] == "A" ? true : false;
        isChecked_B = shiftsArray[1] == "B" ? true : false;
        isChecked_C = shiftsArray[2] == "C" ? true : false;
      }
      isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Add Security'),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            children: <Widget>[
              Container(
                  child: Column(children: [
                SizedBox(height: 30),
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
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    label: Text(
                      "Security Guard Name",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 1200,
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: age_Controller,
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
                              'Age',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Add spacing between text fields
                      Expanded(
                        child: TextField(
                          controller: block_Controller,
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
                              'Block Name',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  controller: address_Controller,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    label: Text(
                      "Address",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 1200,
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: service_starting_Controller,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_month,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () => _serviceStarting(context),
                            ),
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
                              _serviceStartingDate == null
                                  ? 'Service starting date'
                                  : ' ${_serviceStartingDate.toString().substring(0, 10)}',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Add spacing between text fields
                      Expanded(
                        child: TextField(
                          controller: service_ending_Controller,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_month,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () => _serviceEnding(context),
                            ),
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
                              _serviceEndingDate == null
                                  ? 'Service ending date'
                                  : ' ${_serviceEndingDate.toString().substring(0, 10)}',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    children: [
                      new Flexible(
                          child: new SwitchListTile(
                              title: Text(
                                'Active/Inactive',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: status,
                              onChanged: (val) {
                                print(val);
                                setState(() {
                                  status = val;
                                });
                              })),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      new Text('Shifts',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 18))
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Checkbox(
                          value: isChecked_A,
                          onChanged: (val) {
                            setState(() {
                              isChecked_A = val!;
                              print(isChecked_A);
                            });
                          }),
                      Text('A shift',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 40,
                      ),
                      Checkbox(
                          value: isChecked_B,
                          checkColor: Colors.blueAccent,
                          onChanged: (val) {
                            setState(() {
                              isChecked_B = val!;
                              print(isChecked_B);
                            });
                          }),
                      Text('B shift',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 40,
                      ),
                      Checkbox(
                          value: isChecked_C,
                          onChanged: (val) {
                            setState(() {
                              isChecked_C = val!;
                              print(isChecked_C);
                            });
                          }),
                      Text('C shift',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: phoneNumber_controller,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    label: Text(
                      "Mobile number",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: alternatePhoneNumber_controller,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    label: Text(
                      "Alternate mobile number",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ])),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  child: Text(
                    (isEdit ? "Update" : "Add"),
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: isEdit ? updateTodo : AddTodo,
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      side: BorderSide(width: 1),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(10))),
            ],
          ),
        ));
  }

  Future<void> _serviceStarting(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _serviceStartingDate) {
      final selectedDate1 = DateTime(picked.year, picked.month, picked.day);
      setState(() {
        _serviceStartingDate = selectedDate1;
      });
    }
  }

  Future<void> _serviceEnding(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _serviceEndingDate) {
      final selectedDate = DateTime(picked.year, picked.month, picked.day);
      setState(() {
        _serviceEndingDate = selectedDate;
      });
    }
  }

  Future<void> AddTodo() async {
    // print("${president_phone}    ${block_name}");
    String url = NetworkInfo.url2 + "/security_guard.php";
    final name = name_Controller.text;
    final age = age_Controller.text;
    final address = address_Controller.text;
    final block_name = block_Controller.text;
    final service_starting_date =
        _serviceStartingDate.toString().substring(0, 10);
    final service_ending_date = _serviceEndingDate.toString().substring(0, 10);
    final active = status;
    final shiftA = isChecked_A;
    final shiftB = isChecked_B;
    final shiftC = isChecked_C;
    final mobileNumber = phoneNumber_controller.text;
    final alternate_phone_number = alternatePhoneNumber_controller.text;

    print(
        "${name}    ${age}   ${address}   ${service_starting_date}   ${service_ending_date}   ${active}   ${shiftA} "
        "  ${shiftB}   ${shiftC}   ${mobileNumber}    ${alternate_phone_number}");

    if ((name != null || name.isNotEmpty) &&
            (age != null || age.isNotEmpty) &&
            (address != null || address.isNotEmpty) &&
            (service_starting_date != null ||
                service_starting_date.isNotEmpty) &&
            (service_ending_date != null || service_ending_date.isNotEmpty) &&
            (active != null || active.toString().isNotEmpty) &&
            (shiftA != null || shiftA.toString().isNotEmpty) &&
            (shiftB != null || shiftB.toString().isNotEmpty) &&
            (shiftC != null || shiftB.toString().isNotEmpty) &&
            (mobileNumber != null || mobileNumber.isNotEmpty) &&
            alternate_phone_number != null ||
        alternate_phone_number.isNotEmpty) {
      var aShift = shiftA ? "A" : "";
      var bShift = shiftB ? "B" : "";
      var cShift = shiftC ? "C" : "";
      final body = {
        "name": name,
        "age": age,
        "block_name": block_name,
        "address": address,
        "service_starting_date": service_starting_date,
        "service_ending_date": service_ending_date,
        "active": active,
        "shiftA": aShift,
        "shiftB": bShift,
        "shiftC": cShift,
        "mobileNumber": mobileNumber,
        "alternate_phone_number": alternate_phone_number
      };
      final uri = Uri.parse(url);
      var response;

      response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      print("${response.body}");
      print(response.statusCode);
      if (response.statusCode == 201) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PresidentHomeScreen("Home", president_phone, block_name)));
        SnackBarWidget.scaffoldMessage(
            context, "Added successfully", "success");
      } else {
        print("adding failed");
        SnackBarWidget.scaffoldMessage(context, "Adding failed", "error");
      }
    } else {
      print("please enter all the fields");
      SnackBarWidget.scaffoldMessage(
          context, "please enter all the fields", "error");
    }
  }

  Future<void> updateTodo() async {
    final todo = widget.todo;

    String url = NetworkInfo.url2 + "/security_guard.php";
    print(url);
    final security_guard_id = todo!['security_guard_id'];
    final created_date = todo!['created_date'];
    final name = name_Controller.text;
    final age = age_Controller.text;
    final block_name = block_Controller.text;
    final address = address_Controller.text;
    final service_starting_date =
        _serviceStartingDate.toString().substring(0, 10);
    final service_ending_date = _serviceEndingDate.toString().substring(0, 10);
    final active = status;
    final shiftA = isChecked_A;
    final shiftB = isChecked_B;
    final shiftC = isChecked_C;
    final mobileNumber = phoneNumber_controller.text;
    final alternate_phone_number = alternatePhoneNumber_controller.text;

    print(
        "${name}    ${age}   ${address}   ${service_starting_date}   ${service_ending_date}   ${active}   ${shiftA} "
        "  ${shiftB}   ${shiftC}   ${mobileNumber}    ${alternate_phone_number}");

    if ((name != null || name.isNotEmpty) &&
            (age != null || age.isNotEmpty) &&
            (address != null || address.isNotEmpty) &&
            (service_starting_date != null ||
                service_starting_date.isNotEmpty) &&
            (service_ending_date != null || service_ending_date.isNotEmpty) &&
            (active != null || active.toString().isNotEmpty) &&
            (shiftA != null || shiftA.toString().isNotEmpty) &&
            (shiftB != null || shiftB.toString().isNotEmpty) &&
            (shiftC != null || shiftB.toString().isNotEmpty) &&
            (mobileNumber != null || mobileNumber.isNotEmpty) &&
            alternate_phone_number != null ||
        alternate_phone_number.isNotEmpty) {
      var aShift = shiftA ? "A" : "";
      var bShift = shiftB ? "B" : "";
      var cShift = shiftC ? "C" : "";
      final body = {
        "security_guard_id": security_guard_id,
        "created_date": created_date,
        "name": name,
        "block_name": block_name,
        "age": age,
        "address": address,
        "service_starting_date": service_starting_date,
        "service_ending_date": service_ending_date,
        "active": active,
        "shiftA": aShift,
        "shiftB": bShift,
        "shiftC": cShift,
        "mobileNumber": mobileNumber,
        "alternate_phone_number": alternate_phone_number
      };
      final uri = Uri.parse(url);
      var response;

      response = await http.put(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      print(response.body);
      if (response.statusCode == 200) {
        SnackBarWidget.scaffoldMessage(
            context, "Updated successfully", "success");
        Navigator.of(context).pop();
      } else {
        SnackBarWidget.scaffoldMessage(context, "updation failed", "error");
      }
    } else {}
  }
}
