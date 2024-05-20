import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration/utilites/constants.dart';
import 'package:registration/widgets/reusable_appbar.dart';
import 'package:registration/widgets/reusable_input.dart';
import 'package:registration/screens/patient_register_screen.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../widgets/reusable_screenButtons.dart';
import 'package:registration/services/login_to_database.dart';
import 'package:registration/screens/forget_password_screen.dart';

class PatientLoginScreen extends StatefulWidget {
  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
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
                  "Login",
                  style: kPanelTextStyle,
                  textAlign: TextAlign.center,
                ),
                ReusableInput(
                  label: "Email:",
                  hintText: "Enter email",
                  value: (newValue) {
                    setState(() => email = newValue);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ReusableInput(
                  label: "Password:",
                  hintText: "Enter password",
                  value: (newValue) {
                    setState(() => password = newValue);
                  },
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ReusableScreenButtons(
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen(),
                        ),
                      );
                    },
                    text: ' Forgot Password?',
                  ),
                ),
                LoginToDatabase(
                  email: email,
                  password: password,
                  error: (error) {
                    setState(
                      () {
                        this.error = error;
                      },
                    );
                  },
                ),
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
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white60),
                    ),
                    ReusableScreenButtons(
                      onpressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientRegisterScreen(),
                          ),
                        );
                      },
                      text: ' Sign up',
                    ),
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
