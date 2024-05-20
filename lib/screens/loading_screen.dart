import 'package:flutter/material.dart';
import 'package:registration/utilites/constants.dart';
import 'package:registration/widgets/reusable_chooser.dart';
import 'package:registration/screens/patient_login_screen.dart';
import 'package:registration/widgets/reusable_title.dart';
import 'package:registration/screens/personel_login_screen.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kGradientBackground,
        padding: EdgeInsets.symmetric(vertical: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ReusableTitle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReusableChosser(
                  infoText: Text(
                    "Patient",
                    style: kLogoTextStyle,
                  ),
                  image: Image(
                    image: AssetImage('assets/images/patient.png'),
                  ),
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientLoginScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                ReusableChosser(
                  infoText: Text(
                    "Personel",
                    style: kLogoTextStyle,
                  ),
                  image: Image(
                    image: AssetImage('assets/images/personel.png'),
                  ),
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonelLoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
