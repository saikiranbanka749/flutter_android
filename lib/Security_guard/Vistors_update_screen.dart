import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Vistors_update_screen extends StatefulWidget {
  Map<dynamic, dynamic> items;

  Vistors_update_screen(this.items) {
    this.items = items;
  }

  @override
  State<Vistors_update_screen> createState() =>
      _Vistors_update_screenState(items);
}

class _Vistors_update_screenState extends State<Vistors_update_screen> {
  Map<dynamic, dynamic> items;

  _Vistors_update_screenState(this.items) {
    this.items = items;
  }

  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    //   print("State changed ${isValid}");
    // print(items);
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
                        image: new DecorationImage(
                            image: new AssetImage('assets/Allow_Me.gif'))),
                  ),
                  Container(
                      width: 500,
                      height: 400,
                      child: Card(
                          color: Colors.grey,
                          margin: EdgeInsets.only(top: 20),
                          elevation: 9,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Table(children: [
                            TableRow(
                              children: [
                                TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                              fontFamily: 'EBGaramond',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ))),
                                TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          items['visitor_name']
                                                  .substring(0, 1)
                                                  .toUpperCase() +
                                              items['visitor_name']
                                                  .substring(1),
                                          style: TextStyle(
                                              fontFamily: 'EBGaramond',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )))),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          'Gender',
                                          style: TextStyle(
                                              fontFamily: 'EBGaramond',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )))),
                                TableCell(
                                    child: Container(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Text(
                                        items['gender'],
                                        style: TextStyle(
                                            fontFamily: 'EBGaramond',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          'Visitor phone number',
                                          style: TextStyle(
                                              fontFamily: 'EBGaramond',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )))),
                                TableCell(
                                    child: Container(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Text(
                                        items['visitor_mobile_number'],
                                        style: TextStyle(
                                            fontFamily: 'EBGaramond',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          'Flat_number',
                                          style: TextStyle(
                                              fontFamily: 'EBGaramond',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )))),
                                TableCell(
                                    child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        items['flat_number'],
                                        style: TextStyle(
                                            fontFamily: 'EBGaramond',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          'Date',
                                          style: TextStyle(
                                              fontFamily: 'EBGaramond',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )))),
                                TableCell(
                                    child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse(items['date_time']))}',
                                        style: TextStyle(
                                            fontFamily: 'EBGaramond',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Container(
                                            height: 50,
                                            child: Center(
                                                child: Text(
                                              'Status',
                                              style: TextStyle(
                                                  fontFamily: 'EBGaramond',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ))))),
                                TableCell(
                                  child: Container(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            items['status']
                                                    .substring(0, 1)
                                                    .toUpperCase() +
                                                items['status'].substring(1),
                                            style: TextStyle(
                                                color:
                                                    items['status'] != "Pending"
                                                        ? Colors.red
                                                        : Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'EBGaramond',
                                                fontSize: 22),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            )
                          ]))),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 100, horizontal: 120),
                          child: Column(
                            children: [
                              Text(
                                "Enter Otp",
                                style: TextStyle(
                                    fontFamily: 'EBGaramond', fontSize: 22),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              OtpTextField(
                                numberOfFields: 5,
                                borderColor: Colors.lightBlue,
                                showFieldAsBox: true,
                                onCodeChanged: (String code) {},
                                onSubmit: (String verificationCode) async {
                                  await compareOtp(
                                      verificationCode,
                                      items['visitor_mobile_number'],
                                      items['date_time']);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        icon: isValid
                                            ? (Icon(
                                                Icons.verified,
                                                color: Colors.green,
                                              ))
                                            : (Icon(Icons.dangerous,
                                                color: Colors.red)),
                                        content: Text(
                                          isValid ? "Allow" : "Deny",
                                          style: (TextStyle(
                                              color: isValid
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                        ),
                                      );
                                    },
                                  );
                                }, // end onSubmit
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              )),
        ));
  }

  Future<void> compareOtp(
      String verificationCode, String mobile_number, String date) async {
    await Future.delayed(Duration(seconds: 1));
    final url = NetworkInfo.url2 + "/otp_verificaition.php";
    final response = await http.post(Uri.parse(url), body: {
      "verfication_code": verificationCode,
      "visitor_mobile_number": mobile_number,
      "date_time": date,
    });
    print(response.body);
    Map<String, dynamic> jsonMap = json.decode(response.body);

    print(
        "data list is ${jsonMap}   ${jsonMap.runtimeType}        ${jsonMap['status']}");
    if (jsonMap['status'] == "success") {
      // print(isValid);
      setState(() {
        isValid = true;
        print(isValid);
      });
    } else {
      //  print(isValid);
      setState(() {
        isValid = false;
        print(isValid);
      });
    }
    //  return false;
  }
}
