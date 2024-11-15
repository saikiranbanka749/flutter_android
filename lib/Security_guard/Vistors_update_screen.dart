import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/SecurityGuardScreen.dart';
import 'package:allow_me/Security_guard/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VisitorsUpdateScreen extends StatefulWidget {
  final Map<dynamic, dynamic> items;
  String role = '', community_name = '';

  VisitorsUpdateScreen(this.items, this.role, this.community_name);

  @override
  State<VisitorsUpdateScreen> createState() =>
      _VisitorsUpdateScreenState(items, role, community_name);
}

class _VisitorsUpdateScreenState extends State<VisitorsUpdateScreen> {
  Map<dynamic, dynamic> items;
  bool isValid = false;
  String role = '', community_name = '';

  _VisitorsUpdateScreenState(this.items, this.role, this.community_name);

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    print("my role is $role");
    // Get screen height and width
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: (role == 'Security'
            ? AppBar(
                title: Text(role),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.keyboard_backspace_rounded),
                ),
              )
            : null),
        body: Scrollbar(
          controller: controller,
          child: SingleChildScrollView(
            controller: controller,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/Allow_Me.gif'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.6,
                    child: Card(
                      margin: EdgeInsets.only(top: screenHeight * 0.02),
                      elevation: 9,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Table(
                          children: [
                            buildTableRow(
                              'Name',
                              capitalize(items['visitor_name']),
                              TextStyle(
                                fontFamily: 'EBGaramond',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            buildTableRow(
                              'Gender',
                              items['gender'],
                              TextStyle(
                                fontFamily: 'EBGaramond',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            buildTableRow(
                              'Visitor phone number',
                              items['visitor_mobile_number'],
                              TextStyle(
                                fontFamily: 'EBGaramond',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            buildTableRow(
                              'Flat number',
                              items['flat_number'],
                              TextStyle(
                                fontFamily: 'EBGaramond',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            buildTableRow(
                              'Date',
                              DateFormat('dd-MM-yyyy')
                                  .format(DateTime.parse(items['date_time'])),
                              TextStyle(
                                fontFamily: 'EBGaramond',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            buildTableRow(
                              'Status',
                              items['status'],
                              TextStyle(
                                fontFamily: 'EBGaramond',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: items['status'] == "pending"
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                            if (role == "tenant")
                              buildTableRow(
                                'Otp',
                                items['otp'],
                                // Display OTP
                                TextStyle(
                                  fontFamily: 'EBGaramond',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: items['status'] == "pending"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  if (role == "tenant")
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.1,
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          print(items['otp']);
                          shareDialogBox();
                        },
                        icon: Icon(Icons.share),
                        label: Text('Share OTP'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                        ),
                      ),
                    ),
                  if ((role != "tenant" &&
                      items['status'].toLowerCase() == "pending"))
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.1,
                        horizontal: screenWidth * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Enter OTP",
                            style: TextStyle(
                              fontFamily: 'EBGaramond',
                              fontSize: screenHeight * 0.03,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          OtpTextField(
                            numberOfFields: 5,
                            borderColor: Colors.lightBlue,
                            showFieldAsBox: true,
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode) async {
                              await compareOtp(
                                verificationCode,
                                items['visitor_mobile_number'],
                                items['date_time'],
                              );
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    title: Text(isValid ? "Allow" : "Deny",
                                        style: TextStyle(
                                          color: isValid
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenHeight * 0.03,
                                        )),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(!isValid
                                            ? 'Otp not matched'
                                            : "Success"),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            print("here");
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SecurityGuardHomeScreen(
                                                          role,
                                                          community_name,
                                                          ""),
                                                ));
                                          },
                                          child: Text('Close'))
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow buildTableRow(String label, String value, TextStyle valueStyle) {
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
                  fontSize: 22,
                ),
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
                style: valueStyle,
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
    try {
      final url = NetworkInfo.url2 +
          "otp_verification.php"; // Update with your actual API endpoint
      final response = await http.post(Uri.parse(url), body: {
        "verification_code": verificationCode,
        "visitor_mobile_number": mobileNumber,
        "date_time": dateTime,
      });
      print(response.body);
      Map<String, dynamic> jsonMap = json.decode(response.body);
      setState(() {
        isValid = jsonMap['status'] == "success";
      });
    } catch (e) {
      print(e);
    }
  }

  void shareDialogBox() {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Share'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.sms),
                      onPressed: () async {
                        final smsUrl =
                            Uri.parse("sms:?body=Your OTP is: ${items['otp']}");
                        if (await canLaunchUrl(smsUrl)) {
                          await launchUrl(smsUrl);
                        } else {
                          Navigator.of(context).pop();
                        }
                      }),
                  IconButton(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    onPressed: () async {
                      final whatsappUrl = Uri.parse(
                          "whatsapp://send?text=${Uri.encodeComponent("Your OTP is: ${items['otp']}")}");

                      if (await canLaunchUrl(whatsappUrl)) {
                        await launchUrl(whatsappUrl);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("WhatsApp is not installed")),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.email),
                    onPressed: () {
                      // Sharing via Email
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: '',
                        queryParameters: {
                          'subject': 'Your OTP',
                          'body': 'Your OTP is: ${items['otp']}',
                        },
                      );
                      launchUrl(emailUri);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
      animationType: DialogTransitionType.rotate3D,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }

  Future<void> fetchImage() async {}
}
