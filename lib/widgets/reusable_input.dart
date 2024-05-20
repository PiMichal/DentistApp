import 'package:flutter/material.dart';

class ReusableInput extends StatelessWidget {
  ReusableInput(
      {required this.label,
      required this.hintText,
      required this.value,
      this.obscureText = false,
      this.enabled = true});

  final String label;
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final void Function(String) value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          enabled: enabled,
          cursorColor: Colors.white,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 50, right: 50),
            hintStyle: TextStyle(color: Colors.white60),
            hintText: hintText,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
          ),
          textAlign: TextAlign.center,
          onChanged: value,
        ),
      ],
    );
  }
}
