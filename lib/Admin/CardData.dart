import 'package:allow_me/Admin/SuperAdmin.dart';
import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/SnackBarWidget.dart';

class AddNewBlock extends StatefulWidget {
  @override
  State<AddNewBlock> createState() => _AddNewBlockState();
}

class _AddNewBlockState extends State<AddNewBlock> {
  TextEditingController block_name_Controller = TextEditingController();
  TextEditingController president_name_Controller = TextEditingController();
  TextEditingController president_phone_Controller = TextEditingController();
  TextEditingController alternate_phone_Controller = TextEditingController();
  TextEditingController block_located_controller = TextEditingController();
  TextEditingController no_of_blocks_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Community'),
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                //Colors.white,
                Colors.yellow,
                Colors.red,
              ],
            )),
            child: ListView(
              padding: EdgeInsets.only(left: 30, right: 30),
              children: [
                Container(
                  height: 100,
                  width: 520,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: new DecorationImage(
                          image: new AssetImage('assets/Allow_Me.gif'))),
                ),
                SizedBox(
                  height: 100,
                ),
                TextField(
                  controller: block_name_Controller,
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
                        "Community Name",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      prefixIcon: Icon(
                        Icons.home,
                        color: Colors.blueAccent,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: president_name_Controller,
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
                        "President Name",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.blueAccent)),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: president_phone_Controller,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(color: Colors.blueAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                  label: Text(
                                    'President Phone number',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  prefixIcon: Icon(Icons.phone_android_rounded,
                                      color: Colors.blueAccent),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            // Adjust spacing as per your design
                            Expanded(
                              child: TextField(
                                controller: alternate_phone_Controller,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(color: Colors.blueAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                  label: Text(
                                    'Alternate Phone number',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  prefixIcon: Icon(Icons.phone_android_rounded,
                                      color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: no_of_blocks_controller,
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.blueAccent),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent)),
                                label: Text(
                                  'No of blocks',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                prefixIcon: Icon(Icons.apartment,
                                    color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              controller: block_located_controller,
                              decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(color: Colors.blueAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                  label: Text(
                                    "Community Address",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  prefixIcon: Icon(Icons.location_on,
                                      color: Colors.blueAccent)),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    SizedBox(width: 200),
                    ElevatedButton(onPressed: addBlock, child: Text('Add'))
                  ],
                )
              ],
            )));
  }

  Future<void> addBlock() async {
    final block_name = block_name_Controller.text;
    final president_name = president_name_Controller.text;
    final president_phone = president_phone_Controller.text;
    final block_located = block_located_controller.text;
    final alternate_phone = alternate_phone_Controller.text;
    final no_of_blocks = no_of_blocks_controller.text;
    //  print("${block_name}    ${president_name}    ${president_phone}");
    var body = {
      "block_name": block_name,
      "president_name": president_name,
      "president_phone": president_phone,
      "block_located": block_located,
      "no_of_blocks": no_of_blocks,
      "alternate_phone": alternate_phone
    };
    try {
      http.Response response = await http
          .post(Uri.parse(NetworkInfo.url2 + '/blocks.php'), body: body);
      print("${NetworkInfo.url2}blocks.php");
      print(response.body);

      print(response.statusCode);
      if (response.statusCode == 201) {
        print("success");
        SnackBarWidget.scaffoldMessage(
            context, "Block created successfully", "success");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SuperAdmin("President")));
      }
    } catch (e) {
      print(e);
    }
  }
}
