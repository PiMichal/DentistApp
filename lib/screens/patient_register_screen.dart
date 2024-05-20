import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:registration/widgets/reusable_appbar.dart';
import 'package:registration/widgets/reusable_input.dart';
import 'package:registration/utilites/constants.dart';
import 'package:registration/services/register_to_database.dart';
import 'package:registration/widgets/reusable_screenButtons.dart';

class PatientRegisterScreen extends StatefulWidget {
  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  String email = '';
  String password = '';
  String error = '';

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
                  "Register",
                  style: kPanelTextStyle,
                  textAlign: TextAlign.center,
                ),
                ReusableInput(
                  label: "Email:",
                  hintText: "Enter email",
                  value: (newValue) {
                    setState(() {
                      email = newValue;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ReusableInput(
                  label: "Password:",
                  hintText: "Enter password",
                  value: (newValue) {
                    setState(() {
                      password = newValue;
                    });
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                RegisterToDatabase(
                    email: email,
                    password: password,
                    error: (error) {
                      setState(() {
                        this.error = error;
                      });
                    }),
                error.isNotEmpty
                    ? Center(
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Center(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white60),
                    ),
                    ReusableScreenButtons(
                        onpressed: () {
                          Navigator.pop(context);
                        },
                        text: " Sign in"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
