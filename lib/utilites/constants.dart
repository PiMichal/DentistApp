import 'package:flutter/material.dart';

const kGradientBackground = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xff013852),
      Color(0xff00283c),
    ],
  ),
);

const kTitleTextStyle = TextStyle(
  fontFamily: "FjallaOne",
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 35,
  letterSpacing: 5,
);

const kLogoTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
);

const kAppointmentStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kTextMakeAppointmentButtonStyle = TextStyle(
  color: Colors.green,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const kEditTextStyle = TextStyle(
  color: Colors.orange,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

final kEditButtonStyle = ButtonStyle(
  side: MaterialStateProperty.all<BorderSide>(
    BorderSide(color: Colors.orange),
  ),
);

final kMakeAppointmentButtonStyle = ButtonStyle(
  side: MaterialStateProperty.all<BorderSide>(
    BorderSide(color: Colors.green),
  ),
);

const kTextCancelButtonStyle = TextStyle(
  color: Colors.red,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const kPanelTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

final kCancelButtonStyle = ButtonStyle(
  side: MaterialStateProperty.all<BorderSide>(
    BorderSide(color: Colors.red),
  ),
);

const kShowModalBottomSheetStyle = BoxDecoration(
  color: Color(0xff023047),
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(20.0),
  ),
);
