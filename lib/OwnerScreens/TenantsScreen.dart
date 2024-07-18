import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'dart:convert';
import '../AddTenant.dart';
import 'package:http/http.dart' as http;

class TenantsScreen extends StatefulWidget {
  String role, president_phone_number, community_name;

  TenantsScreen(this.role, this.president_phone_number, this.community_name) {
    print(
        "here my block name  is ${community_name} role $role   phone $president_phone_number");
  }

  @override
  State<TenantsScreen> createState() =>
      _TenantsScreenState(role, president_phone_number, community_name);
}

class _TenantsScreenState extends State<TenantsScreen> {
  String role, president_phone_number, community_name;
  bool isLoading = true;
  List items = [];

  _TenantsScreenState(
      this.role, this.president_phone_number, this.community_name);

  @override
  void initState() {
    print(
        "role $role    president_phone:   $president_phone_number    community   $community_name");
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    print("${role}   ${community_name}    ${president_phone_number}");
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                        style: Theme.of(context).textTheme.headlineLarge,
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
                NavigateToAddPage(community_name);
              },
              label: Text("Add Tenant")),
        ));
    ;
  }

  void NavigateToEditPage(Map item) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTenant(
                role: role,
                todo: item,
                community_name: community_name,
                president_phone_number: president_phone_number)));

    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> NavigateToAddPage(String block_name) async {
    print("adding data $block_name adding person $role");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTenant(
                role: role,
                community_name: community_name,
                president_phone_number: president_phone_number)));
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    String url = NetworkInfo.url2 + "/tenant.php/?id=${id}";
    print("hai  ${url}");
    http.Response response = await http.delete(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final filteredItems =
          items.where((element) => element['_id'] != id).toList();
      SnackBarWidget.scaffoldMessage(
          context, "Data deleted successfully", "success");
      setState(() {
        items.remove(id);
        items = filteredItems;
        isLoading = false;
      });
      //  initState();
    }
  }

  Future<void> fetchTodo() async {
    print("my Phone NUmber$president_phone_number   $role");
    String url = NetworkInfo.url2 +
        "/tenant.php?phone_number=${president_phone_number}&role=${role}";
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
