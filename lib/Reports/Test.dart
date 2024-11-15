import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';

class Test {
  static Future<void> signUpUser(
      String username, String password, String dummyText) async {
    try {
      // Create a map for user attributes
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.custom('dummyAttribute'): dummyText,
        // Use custom key here
      };

      SignUpResult res = await Amplify.Auth.signUp(
        username: "rajesh",
        password: "Rahesh123",
        options: SignUpOptions(userAttributes: userAttributes),
      );

      if (res.isSignUpComplete) {
        print('Sign up successful!');
      } else {
        print('Sign up not complete. Check confirmation requirements.');
      }
    } catch (e) {
      print('Sign up failed: $e');
    }
  }
}
