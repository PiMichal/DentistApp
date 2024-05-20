import 'package:flutter/material.dart';

class ReusableScreenButtons extends StatelessWidget {
  ReusableScreenButtons({required this.onpressed, required this.text});

  final Function() onpressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onPressed: onpressed,
    );
  }
}
