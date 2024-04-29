import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SecurityAcceptScreen.dart';

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  int selectedPosition = 1;
  DateTime? _setDateValue;
  DateTime? _setTimeValue, _setInTimeValue, _setOutTimeValue;

  TextEditingController nameController = TextEditingController();
  TextEditingController purposeContoller = TextEditingController();
  TextEditingController flat_numberController = TextEditingController();
  TextEditingController _setDateValueController = TextEditingController();
  TextEditingController _setTimeValueController = TextEditingController();
  TextEditingController _setIntimeController = TextEditingController();
  TextEditingController _setoutTimeController = TextEditingController();
  TextEditingController visitorContactNumberController =
      TextEditingController();
  TextEditingController visitorAdharCardNumberController =
      TextEditingController();
  TextEditingController teenant_number_Controller = TextEditingController();

  GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _globalkey,
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black87),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black87,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black87)),
                    label: Text(
                      "Vistor Name",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
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
                          child: Text(
                        "Gender",
                        style: TextStyle(fontSize: 18),
                      )),
                      Expanded(
                          child: RadioListTile(
                              value: 1,
                              groupValue: selectedPosition,
                              onChanged: (value) {
                                setState(() {
                                  selectedPosition =
                                      int.parse(value.toString());
                                });
                              },
                              title: Text(
                                'Male',
                                style: TextStyle(fontSize: 18),
                              ))),
                      Expanded(
                          child: RadioListTile(
                              value: 2,
                              groupValue: selectedPosition,
                              onChanged: (value) {
                                setState(() {
                                  selectedPosition =
                                      int.parse(value.toString());
                                });
                              },
                              title: Text(
                                'Fe Male',
                                style: TextStyle(fontSize: 18),
                              ))),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  controller: purposeContoller,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black87),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black87,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black87)),
                    label: Text(
                      "Purpose of the visit",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
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
                          controller: flat_numberController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black87)),
                            label: Text(
                              "Flat Number",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child: TextField(
                          controller: teenant_number_Controller,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black87)),
                            label: Text(
                              "Teenant mobile number",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18),
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
                  width: 1200,
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _setDateValueController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_month,
                                color: Colors.black87,
                              ),
                              onPressed: () => _setDate(context),
                            ),
                            hintStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.black87)),
                            label: Text(
                              _setDateValue == null
                                  ? 'Date'
                                  : ' ${_setDateValueController.toString().substring(0, 10)}',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                      // Add spacing between text fields
                      Expanded(
                        child: TextField(
                          controller: _setTimeValueController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.timer_rounded,
                                color: Colors.black87,
                              ),
                              onPressed: () => _setTime(context, "time"),
                            ),
                            hintStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.black87)),
                            label: Text(
                              _setTimeValue == null
                                  ? 'Time'
                                  : ' ${_setTimeValue.toString().substring(0, 10)}',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 1200,
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _setIntimeController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.timer_rounded,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  _setTime(context, "InTime");
                                }),
                            hintStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black87)),
                            label: Text(
                              _setInTimeValue == null
                                  ? 'In Time'
                                  : ' ${_setInTimeValue.toString().substring(0, 10)}',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                      // Add spacing between text fields
                      Expanded(
                        child: TextField(
                          controller: _setoutTimeController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.timer_rounded,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  _setTime(context, "OutTime");
                                }),
                            hintStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black87)),
                            label: Text(
                              _setOutTimeValue == null
                                  ? 'Out Time'
                                  : ' ${_setOutTimeValue.toString().substring(0, 10)}',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 1200,
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          controller: visitorContactNumberController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black87)),
                            label: Text(
                              "Contact number",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                      // Add spacing between text fields
                      Expanded(
                        child: TextField(
                          maxLength: 12,
                          controller: visitorAdharCardNumberController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black87),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black87)),
                            label: Text(
                              "Adhar card number",
                              // _serviceEndingDate == null
                              //     ? 'Service ending date'
                              //     : ' ${_serviceEndingDate.toString().substring(0, 10)}',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: AddVisitor,
                    child: Text(
                      'Submit',
                    ))
              ],
            )),
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
        _setDateValueController.text =
            DateTime(picked.year, picked.month, picked.day)
                .toString()
                .substring(0, 10); // Update the text field
      });
    }
  }

  Future<void> _setTime(BuildContext context, String value) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    print(value);
    if (picked != null && picked != _setTimeValue && value == "time") {
      setState(() {
        _setTimeValueController.text =
            picked.hour.toString() + " : " + picked.minute.toString();
      });
    } else if (picked != null &&
        picked != _setInTimeValue &&
        value == "InTime") {
      setState(() {
        _setIntimeController.text =
            picked.hour.toString() + ":" + picked.minute.toString();
      });
    } else if (picked != null &&
        picked != _setOutTimeValue &&
        value == "OutTime") {
      setState(() {
        _setoutTimeController.text =
            picked.hour.toString() + ":" + picked.minute.toString();
      });
    }
  }

  Future<void> AddVisitor() async {
    final String name = nameController.text.toString();
    final int gender = selectedPosition;
    final String purpose = purposeContoller.text.toString();
    final String flat_number = flat_numberController.text.toString();
    final String date = _setDateValueController.text.toString();
    final String time = _setTimeValueController.text.toString();
    final String inTime = _setIntimeController.text.toString();
    final String outTime = _setoutTimeController.text.toString();
    final String visitorContactNumber =
        visitorContactNumberController.text.toString();
    final String visitorAdharCardNumber =
        visitorAdharCardNumberController.text.toString();
    final String teenantMobileNumber =
        teenant_number_Controller.text.toString();

    final body = {
      "name": name,
      "gender": gender == 1 ? "Male" : "Fe male",
      "purpose": purpose,
      "flat_number": flat_number,
      "date_time": date + "  " + time,
      "inTime": inTime,
      "outTime": outTime,
      "visitorContactNumber": visitorContactNumber,
      "visitorAdarCardNumber": visitorAdharCardNumber,
      "teenantMobileNumber": teenantMobileNumber
    };

    if ((name != null || name.isNotEmpty) &&
        (gender != null) &&
        (purpose != null || purpose.isNotEmpty) &&
        (flat_number != null || flat_number.isNotEmpty) &&
        (date != null || date.isNotEmpty) &&
        (time != null || time.isNotEmpty) &&
        (inTime != null || inTime.isNotEmpty) &&
        (outTime != null || outTime.isNotEmpty) &&
        (visitorAdharCardNumber != null || visitorAdharCardNumber.isNotEmpty) &&
        (visitorContactNumber != null || visitorContactNumber.isNotEmpty)) {
      String url = NetworkInfo.url2 + "/visitor.php";
      try {
        http.Response response = await http.post(Uri.parse(url), body: body);
        print(response.statusCode);
        if (response.statusCode == 201) {
          Navigator.push(context,
              MaterialPageRoute(builder: (cotntext) => SecurityAcceptScreen()));
          SnackBarWidget.scaffoldMessage(
              context, "Request Sent...!", "success");
        } else if (response.statusCode == 400) {
          SnackBarWidget.scaffoldMessage(
              context, "Plese fill all the fields", "errror");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("no");
      const snackBar = SnackBar(content: Text('Please enter all the files'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
