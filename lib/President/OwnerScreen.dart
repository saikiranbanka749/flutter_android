import 'dart:convert';
import 'package:allow_me/AddMulipleOwners.dart';
import 'package:allow_me/PresidentHomeScreen.dart';
import 'package:allow_me/widgets/SnackBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AddOwner.dart';
import '../Login.dart';
import '../Network/NetworkInfo.dart';

class OwnersScreen extends StatefulWidget {
  final String text;
  final String president_phone_number;
  final String community_name;
  final String role;

  OwnersScreen(
      this.text, this.president_phone_number, this.community_name, this.role);

  @override
  _OwnersScreenState createState() {
    return _OwnersScreenState(
        text, president_phone_number, community_name, role);
  }
}

class _OwnersScreenState extends State<OwnersScreen> {
  final String text;
  final String president_phoneNumber;
  final String community_name;
  final String role;
  bool isLoading = true;
  List items = [];
  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();

  _OwnersScreenState(
      this.text, this.president_phoneNumber, this.community_name, this.role);

  @override
  void initState() {
    super.initState();
    print(
        "this is president phone number ${president_phoneNumber}   ${community_name}");
    fetchTodo();
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    var title = text == "Super Admin" ? "${text} - ${community_name}" : text;

    return Scaffold(
      appBar: AppBar(
        leading: (text == "Super Admin"
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.keyboard_backspace_rounded))
            : null),
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: Text('No owners were added.'),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No owners were added.',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            child: AnimatedList(
              key: key,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) {
                final item = items[index] as Map;
                String id = item['owner_id'];
                return _buildItem(item, index, animation, id);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: role != "SuperAdmin"
          ? FloatingActionButton(
              onPressed: () {
                _showOptionsDialog(context);
              },
              child: Icon(Icons.add),
            )
          : null,
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
          title: Text(item['name'],
              style: TextStyle(color: Colors.white, fontSize: 22)),
          subtitle: Text(
              "Flat No: ${item['flat_number']}      ${item['block_name']}  Block",
              style: TextStyle(color: Colors.white, fontSize: 18)),
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
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      Spacer(),
                      Text('Edit'),
                    ],
                  ),
                  value: 'Edit',
                ),
                PopupMenuItem(
                  child: Row(children: [
                    Icon(Icons.delete),
                    Spacer(),
                    Text('Delete'),
                  ]),
                  value: 'Delete',
                ),
              ];
            },
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Owner'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  NavigateToAddPage(community_name, "single");
                },
              ),
              ListTile(
                leading: Icon(Icons.people_alt),
                title: Text('Add multiple'),
                onTap: () {
                  NavigateToAddPage(community_name, "multiple");
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.delete),
              //   title: Text('Delete Owners'),
              //   onTap: () {
              //     Navigator.pop(context); // Close the bottom sheet
              //     // Handle Delete Owners
              //   },
              // ),
              // Add more options here
            ],
          ),
        );
      },
    );
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
          president_phone: president_phoneNumber,
        ),
      ),
    );

    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> NavigateToAddPage(String user, String u_count) async {
    (u_count == "single")
        ? (Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOwner(
                community_name: community_name,
                president_phone: president_phoneNumber,
              ),
            ),
          ))
        : Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMultipleOwners()),
          );
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id, int index) async {
    try {
      String url = NetworkInfo.url2 + "owner.php?id=${id}";
      print(url);
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
                title: Center(
                    child: Text(
                  "Deleted",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 300));

        setState(() {
          items.removeAt(index);
          isLoading = false;
        });

        SnackBarWidget.scaffoldMessage(
            context, "Data deleted successfully", "success");
      } else if (response.statusCode == 400) {
        SnackBarWidget.scaffoldMessage(
            context, "Tenant is available in this flat", "error");
      }
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
    } else {
      // Handle the error accordingly
    }
    setState(() {
      isLoading = false;
    });
  }
}
