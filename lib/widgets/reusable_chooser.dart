import 'package:flutter/material.dart';

class ReusableChosser extends StatelessWidget {
  ReusableChosser(
      {required this.infoText, required this.image, required this.onpressed});

  final Text infoText;
  final Image image;
  final Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          style: ButtonStyle(),
          onPressed: onpressed,
          child: Column(
            children: [
              infoText,
              image,
            ],
          ),
        ),
      ],
    );
  }
}
