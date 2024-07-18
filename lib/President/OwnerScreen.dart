import 'dart:convert';
import 'package:allow_me/PresidentHomeScreen.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:string_capitalize/string_capitalize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AddOwner.dart';
import '../Login.dart';
import '../Network/NetworkInfo.dart';

class OwnersScreen extends StatefulWidget {
  String text, president_phone_number, community_name, role;

  OwnersScreen(
      this.text, this.president_phone_number, this.community_name, this.role);

  @override
  State<OwnersScreen> createState() {
    //  print("block name in owner screen ${block_name}");
    return _OwnersScreenState(
        text, president_phone_number, community_name, role);
  }
}

class _OwnersScreenState extends State<OwnersScreen> {
  String text, president_phoneNumber, community_name, role;

  _OwnersScreenState(
      this.text, this.president_phoneNumber, this.community_name, this.role);

  @override
  void initState() {
    print(
        "this is president phone number ${president_phoneNumber}   ${community_name}");
    super.initState();
    fetchTodo();
    print('init');
  }

  bool isLoading = true;
  List items = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.keyboard_backspace_outlined),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(text),
              backgroundColor: Colors.blueAccent,
            ),
            body: Visibility(
                visible: isLoading,
                child: Center(
                  child: Text('No owners were added.'),
                ),
                replacement: RefreshIndicator(
                    onRefresh: () => fetchTodo(),
                    child: Visibility(
                        visible: items.isNotEmpty,
                        replacement: Center(
                            child: Text(
                          'No owner\'s were added.',
                          style: Theme.of(context).textTheme.headlineLarge,
                        )),
                        child: ListView.builder(
                            itemCount: items.length,
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            itemBuilder: (context, index) {
                              final item = items[index] as Map;
                              String id = item['owner_id'];
                              return Card(
                                  color: Colors.orangeAccent,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Text(item['name'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22)),
                                    subtitle: Text(
                                        "Flat No: ${item['flat_number']}      ${item['block_name']}  Block",
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
            floatingActionButton: role != "SuperAdmin"
                ? (FloatingActionButton.extended(
                    onPressed: () {
                      NavigateToAddPage(community_name);
                    },
                    label: Text("Add Owner")))
                : null));
  }

  void NavigateToEditPage(Map item) async {
    print("edit page ${community_name}");
    print(item);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddOwner(
                todo: item,
                community_name: community_name,
                president_phone: president_phoneNumber)));

    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> NavigateToAddPage(String user) async {
    //  print(block_name);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddOwner(
                community_name: community_name,
                president_phone: president_phoneNumber)));
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    try {
      String url = NetworkInfo.url2 + "owner.php?id=${id}";
      print(url);
      http.Response response = await http.delete(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        final filteredItems =
            items.where((element) => element['_id'] != id).toList();
        setState(() {
          items.remove(id);
          items = filteredItems;
        });
        //  initState();
        SnackBarWidget.scaffoldMessage(
            context, "Data deleted Succesfully", "success");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchTodo() async {
    String url =
        NetworkInfo.url2 + "/owner.php/?phone=${president_phoneNumber}";
    print(url);
    http.Response response = await http.get(Uri.parse(url));
    print("here ${response.body}");
    if (response.statusCode >= 200 && response.statusCode <= 203) {
      List<Map<String, dynamic>> data =
          json.decode(response.body).cast<Map<String, dynamic>>();
      print(data.length);
      setState(() {
        items = data;
      });
      print(items);
    } else {}
    setState(() {
      isLoading = false;
    });
  }
}
