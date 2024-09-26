import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../Network/NetworkInfo.dart';
import '../widgets/DialogueBox.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';

class DownloadSecurityReports extends StatefulWidget {
  const DownloadSecurityReports({Key? key}) : super(key: key);

  @override
  State<DownloadSecurityReports> createState() =>
      _DownloadSecurityReportsState();
}

class _DownloadSecurityReportsState extends State<DownloadSecurityReports> {
  final List<String> timePeriods = ['Yearly', 'Monthly', 'Custom'];
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<String> dates =
      List.generate(31, (index) => (index + 1).toString().padLeft(2, '0'));
  final List<String> hours =
      List.generate(24, (index) => index.toString().padLeft(2, '0'));
  final List<String> minutes =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));

  late List<String> years;
  String? _selectedYear;
  String? _selectedTimePeriod;
  String? _selectedMonth;
  String? _selectedDate;
  String? _selectedHour;
  String? _selectedMinute;
  String? _selectedInDate;
  String? _selectedInHour;
  String? _selectedInMinute;
  String? _selectedOutDate;
  String? _selectedOutHour;
  String? _selectedOutMinute;
  final Map<String, String> monthToNumber = {
    'January': '01',
    'February': '02',
    'March': '03',
    'April': '04',
    'May': '05',
    'June': '06',
    'July': '07',
    'August': '08',
    'September': '09',
    'October': '10',
    'November': '11',
    'December': '12'
  };

  @override
  void initState() {
    super.initState();
    years = List<String>.generate(10, (index) {
      final year = DateTime.now().year - index;
      return year.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.6;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Reports'),
        ),
        body: Center(
          child: Container(
            width: containerWidth,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedTimePeriod,
                  hint: const Text('Select a time period'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: timePeriods.map((String period) {
                    return DropdownMenuItem<String>(
                      value: period,
                      child: Text(period),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTimePeriod = newValue;
                      if (newValue != 'Custom') {
                        _selectedYear = null;
                        _selectedMonth = null;
                        _selectedDate = null;
                        _selectedHour = null;
                        _selectedMinute = null;
                        _selectedInDate = null;
                        _selectedInHour = null;
                        _selectedInMinute = null;
                        _selectedOutDate = null;
                        _selectedOutHour = null;
                        _selectedOutMinute = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                if (_selectedTimePeriod == 'Yearly')
                  DropdownButtonFormField<String>(
                    value: _selectedYear,
                    hint: const Text('Select a year'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedYear = newValue;
                      });
                    },
                  ),
                const SizedBox(height: 16.0),
                if (_selectedTimePeriod == 'Monthly')
                  DropdownButtonFormField<String>(
                    value: _selectedMonth,
                    hint: const Text('Select a month'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMonth = newValue;
                      });
                    },
                  ),
                const SizedBox(height: 16.0),
                if (_selectedTimePeriod == 'Custom') ...[
                  DropdownButtonFormField<String>(
                    value: _selectedYear,
                    hint: const Text('Select a year'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedYear = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedMonth,
                    hint: const Text('Select a month'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMonth = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedDate,
                    hint: const Text('Select a date'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: dates.map((String date) {
                      return DropdownMenuItem<String>(
                        value: date,
                        child: Text(date),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDate = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Start Time:'),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedInDate,
                          hint: const Text('Start date'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: dates.map((String date) {
                            return DropdownMenuItem<String>(
                              value: date,
                              child: Text(date),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedInDate = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedInHour,
                          hint: const Text('Start hour'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: hours.map((String hour) {
                            return DropdownMenuItem<String>(
                              value: hour,
                              child: Text(hour),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedInHour = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedInMinute,
                          hint: const Text('Start minute'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: minutes.map((String minute) {
                            return DropdownMenuItem<String>(
                              value: minute,
                              child: Text(minute),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedInMinute = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Text('End Time:'),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedOutDate,
                          hint: const Text('End date'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: dates.map((String date) {
                            return DropdownMenuItem<String>(
                              value: date,
                              child: Text(date),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedOutDate = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedOutHour,
                          hint: const Text('End hour'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: hours.map((String hour) {
                            return DropdownMenuItem<String>(
                              value: hour,
                              child: Text(hour),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedOutHour = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedOutMinute,
                          hint: const Text('End minute'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: minutes.map((String minute) {
                            return DropdownMenuItem<String>(
                              value: minute,
                              child: Text(minute),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedOutMinute = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 16.0),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_selectedTimePeriod == 'Custom') {
                            if (_selectedYear == null ||
                                _selectedMonth == null ||
                                _selectedDate == null ||
                                _selectedInDate == null ||
                                _selectedInHour == null ||
                                _selectedInMinute == null ||
                                _selectedOutDate == null ||
                                _selectedOutHour == null ||
                                _selectedOutMinute == null) {
                              // SnackBarWidget.scaffoldMessage(
                              //     context, "fill all the fields", "error");
                              CustomDialogBox.DialogBox(
                                  context, "fill all the fields", "error");
                            } else {
                              generateReports(context);
                            }
                          } else {
                            generateReports(context);
                          }
                        },
                        child: Text('Generate Report')))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateReports(BuildContext context) async {
    String timePeriod = _selectedTimePeriod ?? 'None';
    String? monthNumber =
        _selectedMonth != null ? monthToNumber[_selectedMonth!] : null;

    Map<String, dynamic> requestData = {
      'time_period': timePeriod,
      'year': _selectedYear,
      'month': monthNumber,
      'date': _selectedDate,
      'start_time': {
        'start_date': _selectedInDate,
        'hour': _selectedInHour,
        'minute': _selectedInMinute,
      },
      'end_time': {
        'end_date': _selectedOutDate,
        'hour': _selectedOutHour,
        'minute': _selectedOutMinute,
      }
    };
    requestData.removeWhere((key, value) => value == null);

    try {
      final response = await http.post(
        Uri.parse(NetworkInfo.url2 + 'reports.php'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Report generated successfully: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report generated successfully')),
        );

        // Assuming responseData is a list of maps
        await _downloadReport(responseData);
      } else if (response.statusCode == 403) {
        CustomDialogBox.DialogBox(context, "No data available", "info");
      } else {
        print('Failed to generate report: ${response.statusCode}');
        _showError('Failed to generate report. Please try again.');
      }
    } catch (error) {
      print('Error: $error');
      _showError('An error occurred. Please try again.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _downloadReport(List<dynamic> data) async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Add column headers
    sheet.appendRow([
      'ID',
      'Visitor Name',
      'Gender',
      'Purpose',
      'Flat Number',
      'Block Name',
      'Date Time',
      'Tenant Phone',
      'In Time',
      'Out Time',
      'Status',
      'Visitor Aadhar Number',
      'Visitor Mobile Number'
    ]);

    // Add data rows
    for (var row in data) {
      sheet.appendRow([
        row['id'] ?? '',
        row['visitor_name'] ?? '',
        row['gender'] ?? '',
        row['purpose'] ?? '',
        row['flat_number'] ?? '',
        row['block_name'] ?? '',
        row['date_time'] ?? '',
        row['tenant_phone'] ?? '',
        row['in_time'] ?? '',
        row['out_time'] ?? '',
        row['status'] ?? '',
        row['visitor_adhar_number'] ?? '',
        row['visitor_mobile_number'] ?? '',
      ]);
    }

    try {
      final excelBytes = excel.encode();
      if (excelBytes == null) {
        throw Exception('Error encoding Excel file');
      }

      final uint8List = Uint8List.fromList(excelBytes);

      final blob = html.Blob([uint8List]);

      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'report.xlsx')
        ..click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error saving file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download report. Please try again.')),
      );
    }
  }
}
