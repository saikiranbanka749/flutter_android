import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';
import 'package:iconsax/iconsax.dart';

class AddMultipleOwners extends StatefulWidget {
  const AddMultipleOwners({super.key});

  @override
  State<AddMultipleOwners> createState() => _AddMultipleOwnersState();
}

class _AddMultipleOwnersState extends State<AddMultipleOwners> {
  String _displayText = "Upload File";
  html.File? _selectedFile;
  Uint8List? _fileBytes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Upload Excel File')),
        body: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickExcelFile();
                  },
                  child: Container(
                    width: 250,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.document_upload,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            _selectedFile != null
                                ? _selectedFile!.name
                                : _displayText,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedFile != null && _fileBytes != null) {
                      uploadFile();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No file selected')),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickExcelFile() {
    final uploadInput = html.FileUploadInputElement()
      ..accept = '.xlsx,.xls,.csv'
      ..multiple = false;
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files == null || files.isEmpty) {
        print('No file selected');
        return;
      }

      final file = files[0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((e) async {
        final bytes = reader.result as Uint8List;

        // Store selected file and bytes
        setState(() {
          _selectedFile = file;
          _fileBytes = bytes;
          _displayText = file.name; // Update display text with file name
        });

        // Optional: Read the file (for verification or further processing)
        await readExcelFile(bytes);
      });

      reader.readAsArrayBuffer(file);
    });
  }

  Future<void> readExcelFile(Uint8List bytes) async {
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print('Sheet Name: $table'); // Sheet name
      //    print('Sheet Size: ${excel.tables[table]?.maxCols}'); // Sheet size

      for (var row in excel.tables[table]!.rows) {
        print('$row');
      }
    }
  }

  Future<void> uploadFile() async {
    if (_selectedFile == null || _fileBytes == null) {
      print('No file to upload');
      return;
    }

    try {
      final uri = Uri.parse('https://your-backend-url.com/upload');
      final request = http.MultipartRequest('POST', uri);

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        _fileBytes!,
        filename: _selectedFile!.name,
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        setState(() {
          _displayText = "File Uploaded Successfully";
        });
      } else {
        print('File upload failed with status code: ${response.statusCode}');
        setState(() {
          _displayText = "File Upload Failed";
        });
      }
    } catch (e) {
      print('Error during file upload: $e');
      setState(() {
        _displayText = "Error during upload";
      });
    }
  }
}
