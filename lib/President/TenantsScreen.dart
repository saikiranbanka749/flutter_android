import 'package:allow_me/Network/NetworkInfo.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../AddTenant.dart';
import 'package:http/http.dart' as http;

class TenantsScreen extends StatefulWidget {
  final String text;
  final String president_phone_number;
  final String community_name;
  final String role;

  TenantsScreen(
      this.text, this.president_phone_number, this.community_name, this.role) {
    print("here my block name is ${community_name} and role is ${role}");
  }

  @override
  State<TenantsScreen> createState() =>
      _TenantsScreenState(text, president_phone_number, community_name, role);
}

final GlobalKey<AnimatedListState> key = GlobalKey();

class _TenantsScreenState extends State<TenantsScreen> {
  final String text;
  final String president_phone_number;
  final String block_name;
  final String role;
  bool isLoading = true;
  List items = [];

  _TenantsScreenState(
      this.text, this.president_phone_number, this.block_name, this.role);

  @override
  void initState() {
    super.initState();
    print("$text $president_phone_number $block_name $role");
    fetchTodo();
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    print("${text} ${block_name} ${president_phone_number}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: text != null
            ? AppBar(
                title: Text('Tenant'),
                backgroundColor: Colors.blueAccent,
              )
            : null,
        body: Visibility(
          visible: isLoading,
          child: Center(
            child: Text('No Tenants were added.'),
          ),
          replacement: RefreshIndicator(
            onRefresh: fetchTodo,
            child: Visibility(
              visible: items.isNotEmpty,
              replacement: Center(
                child: Text(
                  'No tenants were added.',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              child: AnimatedList(
                key: key,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) {
                  final item = items[index] as Map;
                  String id = item['tenant_id'];
                  return _buildItem(item, index, animation, id);
                },
              ),
            ),
          ),
        ),
        floatingActionButton: role != "SuperAdmin"
            ? FloatingActionButton.extended(
                onPressed: () {
                  NavigateToAddPage(block_name);
                },
                label: Text("Add Tenant"),
              )
            : null,
      ),
    );
  }

  Widget _buildItem(
      Map item, int index, Animation<double> animation, String id) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: Colors.orangeAccent,
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          title: Text(
            item['name'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Phone: ${item['phone']}      ${item['block_name']} Block - ${item['flat_number']}",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == 'Edit') {
                NavigateToEditPage(item);
              } else if (value == 'Delete') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Delete'),
                        children: [
                          Padding(
                            child: Text('Are you sure want to delete?'),
                            padding: EdgeInsets.all(20.0),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      deleteById(id, index);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                              ],
                            ),
                          )
                        ],
                      );
                    });
              }
            },
            itemBuilder: (context) {
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
            },
          ),
        ),
      ),
    );
  }

  void NavigateToEditPage(Map item) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTenant(
          role: text,
          todo: item,
          community_name: block_name,
          president_phone_number: president_phone_number,
        ),
      ),
    );

    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> NavigateToAddPage(String block_name) async {
    print(president_phone_number);
    print("adding data $block_name");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTenant(
          role: role,
          community_name: block_name,
          president_phone_number: president_phone_number,
        ),
      ),
    );
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id, int index) async {
    String url = NetworkInfo.url2 + "tenant.php?id=${id}";
    print("hai ${url}");

    http.Response response = await http.delete(Uri.parse(url));
    print(response.body);

    if (response.statusCode == 200) {
      key.currentState!.removeItem(index, (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            margin: EdgeInsets.all(10),
            color: Colors.red,
            child: ListTile(
              title: Text(
                "Deleted",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      }, duration: Duration(milliseconds: 300));

      setState(() {
        items.removeAt(index);
      });

      SnackBarWidget.scaffoldMessage(
          context, "Data deleted successfully", "success");
    }
  }

  Future<void> fetchTodo() async {
    print(president_phone_number);

    String roleToUse = role;
    if (role == "Home") {
      roleToUse = "AssociationPresident";
    }
    roleToUse = roleToUse.replaceAll(' ', '');

    String url = NetworkInfo.url2 +
        "/tenant.php?phone_number=${president_phone_number}&role=${text}";
    print(url);
    try {
      http.Response response = await http.get(Uri.parse(url));
      print("here ${response.body}");
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            json.decode(response.body).cast<Map<String, dynamic>>();
        print(data);
        setState(() {
          items = data;
        });
      } else {
        // Handle other status codes here
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      // Optionally handle the error, e.g., by showing a snackbar
      setState(() {
        isLoading = false;
      });
    }
  }
}
