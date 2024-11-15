import 'package:allow_me/services/changePassword.dart';
import 'package:allow_me/widgets/DialogueBox.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SecurityGuardSettingScreen extends StatefulWidget {
  final String text, phone, communityName;

  SecurityGuardSettingScreen(this.text, this.phone, this.communityName);

  @override
  State<SecurityGuardSettingScreen> createState() =>
      _SecurityGuardSettingScreenState(text, phone, communityName);
}

class _SecurityGuardSettingScreenState
    extends State<SecurityGuardSettingScreen> {
  final String text, phone, communityName;

  _SecurityGuardSettingScreenState(this.text, this.phone, this.communityName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: [
            _buildSettingTile(
              title: 'Change Password',
              onTap: () {
                _showChangePasswordDialog(context, text, phone, communityName);
              },
            ),
            _buildSettingTile(
              title: 'Change Bio',
              onTap: () {
                // Placeholder for future bio change functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
      {required String title, required VoidCallback onTap}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }

  void _showChangePasswordDialog(
      BuildContext context, String role, String phone, String communityName) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _oldPasswordObscureText = true;
        bool _newPasswordObscureText = true;
        bool _confirmPasswordObscureText = true;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Change Password'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: oldPasswordController,
                      obscureText: _oldPasswordObscureText,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        border: OutlineInputBorder(),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _oldPasswordObscureText =
                                  !_oldPasswordObscureText;
                            });
                          },
                          icon: Icon(
                            _oldPasswordObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: newPasswordController,
                      obscureText: _newPasswordObscureText,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _newPasswordObscureText =
                                  !_newPasswordObscureText;
                            });
                          },
                          icon: Icon(
                            _newPasswordObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: confirmNewPasswordController,
                      obscureText: _confirmPasswordObscureText,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        border: OutlineInputBorder(),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmPasswordObscureText =
                                  !_confirmPasswordObscureText;
                            });
                          },
                          icon: Icon(
                            _confirmPasswordObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancel action
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    String oldPassword = oldPasswordController.text;
                    String newPassword = newPasswordController.text;
                    String confirmNewPassword =
                        confirmNewPasswordController.text;

                    if (newPassword == confirmNewPassword) {
                      print('Changing password...');
                      CPassword.changePassword(
                        context,
                        oldPassword,
                        newPassword,
                        phone,
                        role,
                        communityName,
                      );
                    } else {
                      CustomDialogBox.dialogueAlertBox(
                        context,
                        "New Password does not match with Confirm Password",
                        "error",
                      );
                    }
                  },
                  child: Text('Change Password'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
