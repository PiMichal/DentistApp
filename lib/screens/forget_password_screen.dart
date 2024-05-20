import 'package:flutter/material.dart';
import 'package:registration/utilites/constants.dart';
import 'package:registration/widgets/reusable_appbar.dart';
import 'package:registration/widgets/reusable_input.dart';
import 'package:registration/services/reset_password.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String email = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: ReusableAppbar(),
          body: Container(
            decoration: kGradientBackground,
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Reset password",
                  style: kPanelTextStyle,
                  textAlign: TextAlign.center,
                ),
                ReusableInput(
                  label: "Email:",
                  hintText: "Enter email",
                  value: (newValue) {
                    setState(
                      () {
                        email = newValue;
                      },
                    );
                  },
                ),
                SizedBox(height: 16.0),
                ResetPassword(
                  email: email,
                  error: (error) {
                    setState(() {
                      this._errorMessage = error;
                    });
                  },
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
