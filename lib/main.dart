import 'package:allow_me/AddApartment.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart'; // Add this import
import 'package:flutter/services.dart';
import 'HomeScreen.dart';
import 'amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureAmplify(); // Call the configuration function

  runApp(MaterialApp(
    title: 'Allow me',
    color: Colors.red,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(brightness: Brightness.dark),
    themeMode: ThemeMode.system,
    home: HomeScreen(),
  ));
}

Future _configureAmplify() async {
  try {
    AmplifyStorageS3 storagePlugin = AmplifyStorageS3(
        // prefixResolver: const PassThroughPrefixResolver(),
        );

    print("success");
    AmplifyAuthCognito cognito = AmplifyAuthCognito();
    await Amplify.addPlugins([cognito, storagePlugin]);

    try {
      await Amplify.configure(amplifyconfig);
      print("working fine");
    } catch (e) {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  } on Exception catch (e) {
    print("here");
    print('Could not configure Amplify: $e');
  }
}
