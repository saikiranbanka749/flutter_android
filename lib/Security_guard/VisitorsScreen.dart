import 'dart:html';
import 'dart:io' as fileIO;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import "package:async/async.dart";
import 'dart:convert';
import 'package:universal_platform/universal_platform.dart';
import 'package:http_parser/http_parser.dart';
import 'package:allow_me/SecurityGuardScreen.dart';
import 'package:allow_me/widgets/DialogueBox.dart';
import '../Network/NetworkInfo.dart';
import '../widgets/SnackBarWidget.dart';

class VisitorsScreen extends StatefulWidget {
  final String communityName;

  VisitorsScreen(this.communityName);

  @override
  _VisitorsScreenState createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  final ImagePicker _picker = ImagePicker();
  fileIO.File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _billTypeController = TextEditingController();
  final TextEditingController _flatNumberController = TextEditingController();
  final TextEditingController _setDateValueController = TextEditingController();
  final TextEditingController _setTimeValueController = TextEditingController();
  final TextEditingController _setInTimeController = TextEditingController();
  final TextEditingController _setOutTimeController = TextEditingController();
  final TextEditingController _visitorContactNumberController =
      TextEditingController();
  final TextEditingController _visitorAdharCardNumberController =
      TextEditingController();
  final TextEditingController _tenantNumberController = TextEditingController();
  final TextEditingController _imageNameController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String _selectedOption = 'Bill Distributor';
  String _selectedItem = 'Select Apartment/Block';
  List<String> _apartmentList = [];
  int _selectedPosition = 1;
  DateTime? _setDateValue;
  DateTime? _setTimeValue;
  DateTime? _setInTimeValue;
  DateTime? _setOutTimeValue;

  // Added field to store selected image source
  String _imageSource = 'gallery';

  @override
  void initState() {
    super.initState();
    _setDateValueController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    _setTimeValueController.text = DateFormat('HH:mm').format(DateTime.now());
    _fetchApartments(widget.communityName);
    _imageNameController.text = '';
    print("intialized ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(title: Text('Add Visitor')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildOptionDropdown(),
              SizedBox(height: 30),
              _buildTenantAndVisitorFields(),
              SizedBox(
                height: 20,
              ),
              if (_selectedOption == "Normal Visitor")
                _buildGenderAndFlatNumber(),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 20),
              _buildVisitDetailsFields(),
              SizedBox(height: 20),
              if (_selectedOption == 'Normal Visitor') _buildTimeFields(),
              SizedBox(height: 20),
              _buildContactAndApartmentFields(),
              SizedBox(height: 20),
              if (_selectedOption == 'Normal Visitor') _buildImagePicker(),
              SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionDropdown() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.4,
        margin: EdgeInsets.only(bottom: 20),
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedOption,
          items: <String>['Bill Distributor', 'Normal Visitor']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedOption = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTenantAndVisitorFields() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLength: 10,
            onChanged: (tenantMobileNumber) {
              if (tenantMobileNumber.length == 10) {
                _getTenantDetails(tenantMobileNumber, widget.communityName);
              }
            },
            controller: _tenantNumberController,
            decoration: InputDecoration(
              hintText: "Tenant Mobile Number",
              labelText: "Tenant Mobile Number",
              border: OutlineInputBorder(),
              counterText: "",
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Visitor Name",
              labelText: "Visitor Name",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderAndFlatNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (_selectedOption == 'Normal Visitor')
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text("Gender:"),
                SizedBox(width: 20),
                Radio(
                  value: 1,
                  groupValue: _selectedPosition,
                  onChanged: (value) {
                    setState(() {
                      _selectedPosition = value as int;
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 2,
                  groupValue: _selectedPosition,
                  onChanged: (value) {
                    setState(() {
                      _selectedPosition = value as int;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
          ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: MediaQuery.of(context).size.width > 600 ? 2 : 1,
          child: TextField(
            controller: _flatNumberController,
            decoration: InputDecoration(
              hintText: "Flat Number",
              labelText: "Flat Number",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisitDetailsFields() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _purposeController,
            maxLines: _selectedOption == "Bill Distributor" ? 1 : 4,
            decoration: InputDecoration(
              hintText: _selectedOption == "Bill Distributor"
                  ? "Company/distribution name"
                  : "Purpose of Visit",
              labelText: _selectedOption == "Bill Distributor"
                  ? "Company/distribution name"
                  : "Purpose of Visit",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 20),
        if (_selectedOption != "Normal Visitor")
          Expanded(
            child: TextField(
              controller: _billTypeController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Water bill/Electricity bill/phone bill etc..",
                labelText: "Type of Bill",
                border: OutlineInputBorder(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTimeFields() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _setInTimeController,
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
            controller: _setOutTimeController,
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
    );
  }

  Widget _buildContactAndApartmentFields() {
    return Row(
      children: [
        if (_selectedOption == 'Normal Visitor')
          Expanded(
            child: TextField(
              maxLength: 10,
              controller: _visitorContactNumberController,
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
              border: Border.all(color: Colors.blueAccent, width: 2.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedItem.isNotEmpty ? _selectedItem : null,
              underline: SizedBox(),
              items: _apartmentList.map((String value) {
                return DropdownMenuItem<String>(
                  enabled: false,
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _imageNameController,
                decoration: InputDecoration(
                  labelText: 'Image',
                  hintText: "Image",
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
            ),
            SizedBox(width: 20),
            DropdownButton<String>(
              value: _imageSource,
              items: <String>['camera', 'gallery'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _imageSource = newValue!;
                });
              },
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => _pickAnImage(_imageSource),
              child: Text('Pick Image'),
            ),
          ],
        ),
        SizedBox(height: 20),
        if (_image != null && !UniversalPlatform.isWeb)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(_image!),
          )
        else if (UniversalPlatform.isWeb &&
            _imageNameController.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(_imageNameController.text),
          )
        else
          Text('No image selected.'),
      ],
    );
  }

  Future<void> _pickAnImage(String source) async {
    print("i am here $source");
    final ImageSource imageSource =
        source == 'camera' ? ImageSource.camera : ImageSource.gallery;
    final XFile? pickedImage = await _picker.pickImage(
      source: imageSource,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        _image = fileIO.File(pickedImage.path);
        _imageNameController.text = pickedImage.path;
        // or the URL if you are uploading it
        print(pickedImage);
      });
    }
    //print(pickedImage.name);
    print(_image);
    print(_imageNameController.text);
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
        _setDateValueController.text = DateFormat('yyyy-MM-dd').format(picked);
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
        _setTimeValueController.text = formattedTime;
      } else if (field == "InTime") {
        _setInTimeController.text = formattedTime;
      } else if (field == "OutTime") {
        _setOutTimeController.text = formattedTime;
      }
    }
  }

  Future<void> _addVisitor() async {
    final uri = Uri.parse(NetworkInfo.url2 + "/visitor.php");

    // Check if an image is selected
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image first!')),
      );
      return;
    }

    try {
      if (kIsWeb) {
        // For web upload
        final response = await html.HttpRequest.request(
          _image!.path,
          method: 'GET',
          responseType: 'blob',
        );
        if (response.status == 200) {
          final reader = html.FileReader();
          reader.readAsDataUrl(response.response);
          reader.onLoadEnd.listen((event) async {
            String base64String = reader.result as String;

            var formData = jsonEncode({
              'name': _nameController.text.trim(),
              'gender': _selectedPosition == 1 ? "Male" : "Female",
              'purpose': _purposeController.text.trim(),
              'flat_number': _flatNumberController.text.trim(),
              'date_time':
                  "${_setDateValueController.text.trim()} ${_setTimeValueController.text.trim()}",
              'inTime': _setInTimeController.text.trim(),
              'outTime': _setOutTimeController.text.trim(),
              'visitorType': _selectedOption,
              'billType': _billTypeController.text.trim(),
              'visitorContactNumber':
                  _visitorContactNumberController.text.trim(),
              'tenantMobileNumber': _tenantNumberController.text.trim(),
              'role': 'visitor',
              'block_name': _selectedItem,
              'image_name': _imageNameController.text,
              'visitor_image': base64String,
            });

            var request = html.HttpRequest();
            request.open('POST', uri.toString());
            request.setRequestHeader('Content-Type', 'application/json');
            request.send(formData);

            print(request.response);

            request.onLoadEnd.listen((e) {
              print(request.response);
              print(request.status);
              if (request.status == 201) {
                CustomDialogBox.DialogBox(
                    context, "Visitor details have been submitted", "success");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecurityGuardHomeScreen(
                        'Security Guard', widget.communityName),
                  ),
                );
              } else if (request.status == 400) {
                SnackBarWidget.scaffoldMessage(
                    context, "Tenant not found with that number", "error");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Upload failed: ${request.status}')),
                );
                throw Exception('Failed to add visitor');
              }
            });
          });
        }
      } else {
        // For mobile upload
        var formData = FormData.fromMap({
          'name': _nameController.text.trim(),
          'gender': _selectedPosition == 1 ? "Male" : "Female",
          'purpose': _purposeController.text.trim(),
          'flat_number': _flatNumberController.text.trim(),
          'date_time':
              "${_setDateValueController.text.trim()} ${_setTimeValueController.text.trim()}",
          'inTime': _setInTimeController.text.trim(),
          'outTime': _setOutTimeController.text.trim(),
          'visitorType': _selectedOption,
          'billType': _billTypeController.text.trim(),
          'visitorContactNumber': _visitorContactNumberController.text.trim(),
          'tenantMobileNumber': _tenantNumberController.text.trim(),
          'role': 'visitor',
          'block_name': _selectedItem,
          'image_name': _imageNameController.text,
          'visitor_image': await MultipartFile.fromFile(
            _image!.path,
            filename: path.basename(_image!.path),
            contentType: MediaType('image', 'jpeg'), // Adjust if necessary
          ),
        });

        Response response = await Dio().post(
          uri.toString(),
          data: formData,
          options: Options(headers: {"Content-Type": "multipart/form-data"}),
        );

        if (response.statusCode == 200) {
          CustomDialogBox.DialogBox(
              context, "Visitor details have been submitted", "success");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SecurityGuardHomeScreen(
                  'Security Guard', widget.communityName),
            ),
          );
        } else if (response.statusCode == 400) {
          SnackBarWidget.scaffoldMessage(
              context, "Tenant not found with that number", "error");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: ${response.statusCode}')),
          );
          throw Exception('Failed to add visitor');
        }
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.response?.data}');
        print('Status Code: ${e.response?.statusCode}');
        SnackBarWidget.scaffoldMessage(
            context, "Error: ${e.response?.data}", "error");
      } else {
        print('Error: $e');
        SnackBarWidget.scaffoldMessage(
            context, "Failed to add visitor", "error");
      }
    }
  }

  Future<void> _getTenantDetails(
      String tenantMobileNumber, String communityName) async {
    try {
      final String url =
          '${NetworkInfo.url2}visitor.php?phone_number=$tenantMobileNumber&community_name=$communityName';
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('flat_number') &&
            data.containsKey('name') &&
            data.containsKey('block_name')) {
          setState(() {
            _flatNumberController.text = data['flat_number'].toString();
            _apartmentList = [data['block_name'].toString()];
            _selectedItem = _apartmentList.first;
          });
        } else {
          CustomDialogBox.DialogBox(
              context, "Tenant details are incomplete", "warning");
        }
      } else {
        CustomDialogBox.DialogBox(
            context, "Tenant not found with this mobile number", "warning");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> _fetchApartments(String communityName) async {
    final String url =
        '${NetworkInfo.url2}/owner.php?community_name=$communityName';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _apartmentList = data
              .map<String>((item) => item['apartment_name'] as String)
              .toList();
          if (_apartmentList.isNotEmpty) {
            _selectedItem = _apartmentList.first;
          }
        });
      } else {
        print("Failed to fetch apartments: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _addVisitor,
        child: Text('Submit'),
      ),
    );
  }
}
