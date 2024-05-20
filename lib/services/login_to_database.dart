import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/patient_menu_screen.dart';
import 'package:registration/screens/personel_menu_screen.dart';
import 'package:registration/utilites/config.dart';

class LoginToDatabase extends StatelessWidget {
  LoginToDatabase({
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
          final user = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          if (user != null) {
            progress?.dismiss();
            if (email == ADMIN_EMAIL) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonelMenuScreen(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientMenuScreen(),
                ),
              );
            }
          }
        } catch (e) {
          Future.delayed(
            Duration(seconds: 1),
            () {
              progress?.dismiss();
              email == ADMIN_EMAIL
                  ? error('Wrong password!')
                  : error('Wrong email or password!');
            },
          );
          print(e);
        }
      },
      child: Text("Login"),
    );
  }
}
