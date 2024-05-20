import 'package:flutter/material.dart';
import 'package:registration/widgets/reusable_title.dart';
import 'package:registration/screens/loading_screen.dart';

class ReusableAppbar extends StatelessWidget implements PreferredSizeWidget {
  ReusableAppbar({this.automaticallyImplyLeading = true});

  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      centerTitle: true,
      actions: [
        automaticallyImplyLeading
            ? Container()
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LoadingScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: Icon(
                  Icons.exit_to_app,
                  size: 30,
                ),
              )
      ],
      title: ReusableTitle(
        iconSize: 40.0,
        textSize: 5,
      ),
      backgroundColor: Color(0xff00171f),
    );
  }
}
