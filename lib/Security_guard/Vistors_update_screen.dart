import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VisitorsUpdateScreen extends StatefulWidget {
  final Map<dynamic, dynamic> items;

  VisitorsUpdateScreen(this.items);

  @override
  State<VisitorsUpdateScreen> createState() =>
      _VisitorsUpdateScreenState(items);
}

class _VisitorsUpdateScreenState extends State<VisitorsUpdateScreen> {
  Map<dynamic, dynamic> items;
  bool isValid = false;

  _VisitorsUpdateScreenState(this.items);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Allow me'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.keyboard_backspace_outlined),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 520,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/Allow_Me.gif'),
                  ),
                ),
              ),
              Container(
                width: 500,
                height: 400,
                child: Card(
                  color: Colors.grey,
                  margin: EdgeInsets.only(top: 20),
                  elevation: 9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Table(
                    children: [
                      buildTableRow('Name', capitalize(items['visitor_name'])),
                      buildTableRow('Gender', items['gender']),
                      buildTableRow('Visitor phone number',
                          items['visitor_mobile_number']),
                      buildTableRow('Flat number', items['flat_number']),
                      buildTableRow(
                          'Date',
                          DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(items['date_time']))),
                      buildTableRow('Status', capitalize(items['status'])),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 100, horizontal: 120),
                child: Column(
                  children: [
                    Text(
                      "Enter OTP",
                      style: TextStyle(fontFamily: 'EBGaramond', fontSize: 22),
                    ),
                    SizedBox(height: 20),
                    OtpTextField(
                      numberOfFields: 5,
                      borderColor: Colors.lightBlue,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {},
                      onSubmit: (String verificationCode) async {
                        await compareOtp(verificationCode,
                            items['visitor_mobile_number'], items['date_time']);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                isValid ? "Allow" : "Deny",
                                style: TextStyle(
                                  color: isValid ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            height: 50,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                    fontFamily: 'EBGaramond',
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            height: 50,
            child: Center(
              child: Text(
                capitalize(value),
                style: TextStyle(
                    fontFamily: 'EBGaramond',
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String capitalize(String s) {
    if (s.isEmpty) return '';
    return s.substring(0, 1).toUpperCase() + s.substring(1);
  }

  Future<void> compareOtp(
      String verificationCode, String mobileNumber, String dateTime) async {
    await Future.delayed(Duration(seconds: 1));
    final url =
        "your_api_endpoint_here"; // Update with your actual API endpoint
    final response = await http.post(Uri.parse(url), body: {
      "verification_code": verificationCode,
      "visitor_mobile_number": mobileNumber,
      "date_time": dateTime,
    });

    Map<String, dynamic> jsonMap = json.decode(response.body);
    setState(() {
      isValid = jsonMap['status'] == "success";
    });
  }
}
