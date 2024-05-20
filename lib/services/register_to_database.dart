import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/patient_menu_screen.dart';

class RegisterToDatabase extends StatelessWidget {
  RegisterToDatabase({
    required this.email,
    required this.password,
    required this.error,
  });

  final String email;
  final String password;
  final Function(String) error;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueAccent),
      ),
      onPressed: () async {
        error('');

        final progress = ProgressHUD.of(context);
        progress?.show();
        try {
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          if (newUser != null) {
            progress?.dismiss();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientMenuScreen(),
              ),
            );
          }
        } catch (e) {
          int colonIndex = e.toString().indexOf(']');
          Future.delayed(
            Duration(seconds: 1),
            () {
              progress?.dismiss();

              (colonIndex != -1 &&
                      colonIndex + 1 < e.toString().length &&
                      email != "" &&
                      password != "")
                  ? error(e.toString().substring(colonIndex + 1).trim())
                  : error('Incorrect data!');
            },
          );
        }
      },
      child: Text("Register"),
    );
  }
}
