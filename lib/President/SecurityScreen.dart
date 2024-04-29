import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../AddSecurity.dart';
import 'package:http/http.dart' as http;

class SecurityScreen extends StatefulWidget {
  String text, president_phone, block_name;

  SecurityScreen(this.text, this.president_phone, this.block_name);

  @override
  State<SecurityScreen> createState() =>
      _SecurityScreenState(text, president_phone, block_name);
}

class _SecurityScreenState extends State<SecurityScreen> {
  String text, president_phone, block_name;
  bool isLoading = true;
  List items = [];

  _SecurityScreenState(this.text, this.president_phone, this.block_name);

  @override
  void initState() {
    super.initState();
    fetchTodo();
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(text),
            backgroundColor: Colors.blueAccent,
          ),
          body: Visibility(
              visible: isLoading,
              child: Center(
                child: Text('No Security Persons were added.',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              replacement: RefreshIndicator(
                  onRefresh: fetchTodo,
                  child: Visibility(
                      visible: items.isNotEmpty,
                      replacement: Center(
                          child: Text(
                        'No security person\'s were added.',
                        style: Theme.of(context).textTheme.headline3,
                      )),
                      child: ListView.builder(
                          itemCount: items.length,
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          itemBuilder: (context, index) {
                            final item = items[index] as Map;
                            String id = item['security_guard_id'];
                            return Card(
                                color: Colors.orangeAccent,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(item['name'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22)),
                                  subtitle: Text(item['phone'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  trailing:
                                      PopupMenuButton(onSelected: (value) {
                                    if (value == 'Edit') {
                                      NavigateToEditPage(item);
                                    } else if (value == 'Delete') {
                                      deleteById(id);
                                      print("delete");
                                    }
                                  }, itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text('Edit'),
                                        value: 'Edit',
                                      ),
                                      PopupMenuItem(
                                        child: Text('Delete'),
                                        value: 'Delete',
                                      ),
                                    ];
                                  }),
                                ));
                          })))),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                NavigateToAddPage();
              },
              label: Text("Add Security")),
        ));
    ;
  }

  void NavigateToEditPage(Map item) async {
    print("edit page ");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddSecurity(
                president_phone: president_phone,
                todo: item,
                block_name: block_name)));

    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> NavigateToAddPage() async {
    print('${president_phone}    ${block_name}');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddSecurity(
                president_phone: president_phone, block_name: block_name)));
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    String url = "http://192.168.2.142/allowMe/security_guard.php/?id=${id}";
    print("hai  ${url}");
    http.Response response = await http.delete(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final filteredItems =
          items.where((element) => element['_id'] != id).toList();
      setState(() {
        items.remove(id);
        items = filteredItems;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'Action',
            onPressed: () {
              // Code to execute.
            },
          ),
          content: const Text('Data deleted successfully'),
          duration: const Duration(milliseconds: 1500),
          width: 280.0,
          // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchTodo() async {
    String url = NetworkInfo.url2 +
        "/security_guard.php?phone_number=${president_phone}";
    print(url);
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          json.decode(response.body).cast<Map<String, dynamic>>();
      //List data1 = data as List;
      print(data);
      setState(() {
        items = data;
      });
    } else {}
    setState(() {
      isLoading = false;
    });
  }
}
