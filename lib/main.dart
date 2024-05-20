import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:registration/services/event_data.dart';
import 'utilites/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: API_KEY,
          appId: API_ID,
          messagingSenderId: MESSAGING_SENDER_ID,
          projectId: PROJECT_ID),
    );
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(DentistClinic());
}

class DentistClinic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EventData(),
      child: MaterialApp(
        title: "Dentist Clinic",
        theme: ThemeData().copyWith(
            textTheme: TextTheme(
              titleMedium: TextStyle(color: Colors.white),
            ),
            textSelectionTheme:
                TextSelectionThemeData(selectionHandleColor: Colors.white)),
        home: LoadingScreen(),
      ),
    );
  }
}
