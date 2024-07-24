import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleDialogBoxDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SimpleDialogBoxDemo();
}

class _SimpleDialogBoxDemo extends State<SimpleDialogBoxDemo> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Center(
          child: ElevatedButton(
            child: Text('show dialog'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Flutter simple Dialog'),
                      children: [
                        Padding(
                          child: Text('More info here'),
                          padding: EdgeInsets.all(20.0),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('close'))
                      ],
                    );
                  });
            },
          ),
        )),
      ),
    );
  }
}
