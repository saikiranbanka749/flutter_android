import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../AddTenant.dart';
import 'package:http/http.dart' as http;

class TenantsScreen extends StatefulWidget {
  String text, president_phone_number, block_name;

  TenantsScreen(this.text, this.president_phone_number, this.block_name) {
    print("here my block name  is ${block_name}");
  }

  @override
  State<TenantsScreen> createState() =>
      _TenantsScreenState(text, president_phone_number, block_name);
}

class _TenantsScreenState extends State<TenantsScreen> {
  String text, president_phone_number, block_name;
  bool isLoading = true;
  List items = [];

  _TenantsScreenState(this.text, this.president_phone_number, this.block_name);

  @override
  void initState() {
    super.initState();
    fetchTodo();
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    print("${text}   ${block_name}    ${president_phone_number}");
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: text != null
              ? (AppBar(
                  title: Text(text),
                  backgroundColor: Colors.blueAccent,
                ))
              : null,
          body: Visibility(
              visible: isLoading,
              child: Center(
                child: Text('No Tenant\'s were added.'),
              ),
              replacement: RefreshIndicator(
                  onRefresh: fetchTodo,
                  child: Visibility(
                      visible: items.isNotEmpty,
                      replacement: Center(
                          child: Text(
                        'No tenants\'s were added.',
                        style: Theme.of(context).textTheme.headline3,
                      )),
                      child: ListView.builder(
                          itemCount: items.length,
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          itemBuilder: (context, index) {
                            final item = items[index] as Map;
                            String id = item['tenant_id'];
                            return Card(
                                color: Colors.orangeAccent,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(item['name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
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
                NavigateToAddPage(block_name);
              },
              label: Text("Add Owner")),
        ));
    ;
  }

  void NavigateToEditPage(Map item) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTenant(
                todo: item,
                block_name: block_name,
                president_phone_number: president_phone_number)));

    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> NavigateToAddPage(String block_name) async {
    print("adding data $block_name");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTenant(
                block_name: block_name,
                president_phone_number: president_phone_number)));
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    String url = "http://192.168.2.142/allowMe/tenant.php/?id=${id}";
    print("hai  ${url}");
    http.Response response = await http.delete(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final filteredItems =
          items.where((element) => element['_id'] != id).toList();
      SnackBarWidget.scaffoldMessage(
          context, "Data deleted successfully", "success");
      setState(() {
        // items.remove(id);
        items = filteredItems;
        isLoading = false;
      });
      //  initState();
    }
  }

  Future<void> fetchTodo() async {
    String url =
        NetworkInfo.url2 + "/tenant.php?phone_number=${president_phone_number}";
    print(url);
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          json.decode(response.body).cast<Map<String, dynamic>>();
      //List data1 = data as List;
      setState(() {
        items = data;
      });
    } else {}
    setState(() {
      isLoading = false;
    });
  }
}
