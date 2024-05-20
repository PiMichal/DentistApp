import 'package:flutter/material.dart';
import 'package:registration/utilites/constants.dart';

class ReusableTitle extends StatelessWidget {
  ReusableTitle({this.iconSize = 50.0, this.textSize = 10.0});

  final double iconSize;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Dentist", style: kTitleTextStyle),
        SizedBox(
          width: textSize,
        ),
        Image(
          image: AssetImage('assets/images/tooth.png'),
          height: iconSize,
          color: Colors.white,
        ),
        SizedBox(
          width: textSize,
        ),
        Text("Clinic", style: kTitleTextStyle),
      ],
    );
  }
}
