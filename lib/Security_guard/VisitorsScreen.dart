import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Network/NetworkInfo.dart'; // Adjust path as per your project structure
import 'SecurityAcceptScreen.dart'; // Adjust path as per your project structure
import '../widgets/SnackBarWidget.dart'; // Adjust path as per your project structure

class VisitorsScreen extends StatefulWidget {
  final String communityName;

  VisitorsScreen(this.communityName);

  @override
  State<StatefulWidget> createState() => _VisitorsScreenState(communityName);
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  String communityName = '';

  _VisitorsScreenState(this.communityName);

  int selectedPosition = 1;
  DateTime? _setDateValue;

  List<String> apartmentList = [];
  String _selectedItem = 'Select Apartment/Block';
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

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchApartments(widget.communityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Add Visitor'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (tenantMobileNumber) {
                        if (tenantMobileNumber.length == 10) {
                          getTenantDetails(tenantMobileNumber, communityName);
                        }
                      },
                      controller: teenantNumberController,
                      decoration: InputDecoration(
                        hintText: "Tenant Mobile Number",
                        labelText: "Tenant Mobile Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Visitor Name",
                        labelText: "Visitor Name",
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
                    child: Row(
                      children: [
                        Text("Gender:"),
                        SizedBox(width: 50),
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
                  ),
                  Expanded(
                    child: TextField(
                      controller: flatNumberController,
                      decoration: InputDecoration(
                        hintText: "Flat Number",
                        labelText: "Flat Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: purposeController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Purpose of Visit",
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
                      controller: setDateValueController,
                      decoration: InputDecoration(
                        hintText: "Date",
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
                        hintText: "Time",
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
                        hintText: "In Time",
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
                        hintText: "Out Time",
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
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: visitorContactNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Visitor Contact Number",
                        labelText: "Visitor Contact Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Expanded(
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
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: visitorAdharCardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Visitor Aadhar Card Number",
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

  Future<void> addVisitor() async {
    final String name = nameController.text.trim();
    final int gender = selectedPosition;
    final String purpose = purposeController.text.trim();
    final String flatNumber = flatNumberController.text.trim();
    final String date = setDateValueController.text.trim();
    final String time = setTimeValueController.text.trim();
    final String inTime = setIntimeController.text.trim();
    final String outTime = setOutTimeController.text.trim();
    final String block_name = _selectedItem.toString();
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
      final Map<String, String> body = {
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
        "block_name": block_name
      };

      try {
        final response = await http.post(
          Uri.parse(NetworkInfo.url2 + "/visitor.php"),
          body: body,
        );
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 201) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SecurityAcceptScreen()),
          );
          SnackBarWidget.scaffoldMessage(
              context, "Request Sent...!", "success");
        } else if (response.statusCode == 400) {
          SnackBarWidget.scaffoldMessage(
              context, "Tenant not found with that number", "error");
        } else {
          throw Exception('Failed to add visitor');
        }
      } catch (e) {
        print("Exception: $e");
        SnackBarWidget.scaffoldMessage(
            context, "Failed to add visitor", "error");
      }
    } else {
      SnackBarWidget.scaffoldMessage(
          context, "Please enter all fields", "error");
    }
  }

  Future<void> getTenantDetails(
      String tenantMobileNumber, String communityName) async {
    //communityName = communityName.replaceAll(" ", '');
    try {
      String url = NetworkInfo.url2 +
          "visitor.php?phone_number=$tenantMobileNumber&community_name=$communityName";
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            json.decode(response.body).cast<Map<String, dynamic>>();
        if (data.isNotEmpty) {
          setState(() {
            flatNumberController.text = data[0]['flat_number'].toString();
            nameController.text = data[0]['name'].toString();
            selectedPosition = data[0]['gender'];
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Tenant not found with that mobile number'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
        print("Failed to fetch tenant details: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> fetchApartments(String communityName) async {
    String url = NetworkInfo.url2 + "/owner.php?community_name=$communityName";
    try {
      http.Response response = await http.get(Uri.parse(url));
      print("Fetching apartments...");
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          apartmentList =
              data.map<String>((item) => item['apartment_name']).toList();
          if (apartmentList.isNotEmpty) {
            _selectedItem = apartmentList[0];
          }
        });
      } else {
        print("Failed to fetch apartments: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
