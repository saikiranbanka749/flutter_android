import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestingScreen extends StatefulWidget {
  const RequestingScreen();

  @override
  State<RequestingScreen> createState() => _RequestingScreenState();
}

class _RequestingScreenState extends State<RequestingScreen> {
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
                  decoration: InputDecoration(
                    labelText: "Visitor Contact Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: visitorAdharCardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Visitor Aadhar Card Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: addVisitor,
                //     child: Text('Submit'),
                //   ),
                // ),
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
}
