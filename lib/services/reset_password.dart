import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({required this.email, required this.error});

  final _auth = FirebaseAuth.instance;
  final String email;
  final Function(String) error;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueAccent),
      ),
      onPressed: () async {
        final progress = ProgressHUD.of(context);
        try {
          progress?.show();
          await _auth.sendPasswordResetEmail(email: email);
          progress?.dismiss();
          error('Password reset email sent. Please check your email.');
        } catch (e) {
          Future.delayed(
            Duration(seconds: 1),
            () {
              progress?.dismiss();
              print(e);
              error(
                'Error sending password reset email. Please try again later.',
              );
            },
          );
        }
      },
      child: Text('Send Reset Email'),
    );
  }
}
