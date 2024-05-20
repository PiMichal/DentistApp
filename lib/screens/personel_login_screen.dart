import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:registration/widgets/reusable_appbar.dart';
import 'package:registration/utilites/constants.dart';
import 'package:registration/widgets/reusable_input.dart';
import 'package:registration/services/login_to_database.dart';
import 'package:registration/utilites/config.dart';

class PersonelLoginScreen extends StatefulWidget {
  @override
  State<PersonelLoginScreen> createState() => _PersonelLoginScreenState();
}

class _PersonelLoginScreenState extends State<PersonelLoginScreen> {
  String email = ADMIN_EMAIL;
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
                  "Personel",
                  style: kPanelTextStyle,
                  textAlign: TextAlign.center,
                ),
                ReusableInput(
                  label: "Admin:",
                  hintText: "Admin",
                  enabled: false,
                  value: (newValue) {},
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
                SizedBox(
                  height: 10,
                ),
                LoginToDatabase(
                    email: email,
                    password: password,
                    error: (error) {
                      setState(() {
                        this.error = error;
                      });
                    }),
                Center(
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
