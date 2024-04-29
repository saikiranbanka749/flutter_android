import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecurityAcceptScreen extends StatefulWidget {
  const SecurityAcceptScreen({super.key});

  @override
  State<SecurityAcceptScreen> createState() => _SecurityAcceptScreenState();
}

class _SecurityAcceptScreenState extends State<SecurityAcceptScreen> {
  bool _showButton = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          // appBar: AppBar(
          //   title: Text('Allow me'),
          // ),
          body: Container(
              child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            height: 100,
            width: 520,
            decoration: BoxDecoration(
                color: Colors.white,
                image: new DecorationImage(
                    image: new AssetImage('assets/Allow_Me.gif'))),
          ),
          SizedBox(
            height: 100,
          ),
          TweenAnimationBuilder<Duration>(
              duration: Duration(minutes: 3),
              tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
              onEnd: () {
                print('Timer ended');
              },
              builder: (BuildContext context, Duration value, Widget? child) {
                final minutes = value.inMinutes;
                final seconds = value.inSeconds % 60;
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '$minutes:$seconds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: (value.inMinutes > 1)
                              ? Colors.green
                              : (value.inMinutes == 1)
                                  ? Colors.orange
                                  : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 78,
                          fontFamily: 'EBGaramond'),
                    ));
              }),
          SizedBox(
            height: 100,
          ),
          Text(
            'Waiting for teenant response',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 32,
                fontFamily: 'EBGaramond'),
          ),
          SizedBox(
            height: 70,
          ),
          Center(
            child: _showButton
                ? ElevatedButton(
                    onPressed: () {
                      // Button action
                    },
                    child: Text('My Button'),
                  )
                : CircularProgressIndicator(), // Show loading indicator until response
          ),
        ],
      ))),
    );
  }
}
