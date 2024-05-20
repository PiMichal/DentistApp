import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:registration/widgets/reusable_appbar.dart';
import 'package:registration/utilites/constants.dart';
import 'package:registration/model/calendar.dart';
import 'package:registration/model/show_events.dart';
import 'package:registration/services/event_data.dart';

class PatientMenuScreen extends StatefulWidget {
  @override
  State<PatientMenuScreen> createState() => _PatientMenuScreenState();
}

class _PatientMenuScreenState extends State<PatientMenuScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<EventData>(context, listen: false).deleteExpiredDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final eventData = Provider.of<EventData>(context);
    return Scaffold(
      appBar: ReusableAppbar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: kGradientBackground,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                eventData.checkIfTheUserHasAnAppointment()
                    ? "You have an appointment on ${eventData.getEventsForUser()!.getDateTimeString()}"
                    : "Make an appointment",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Calendar(),
              ShowEvents(),
              SizedBox(
                height: 10,
              ),
              eventData.checkIfTheUserHasAnAppointment()
                  ? FilledButton(
                      onPressed: () {
                        eventData.updateEventStatus(
                          eventData.getEventsForUser()!.documentId,
                          true,
                        );
                        eventData.loadEvents();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.red),
                      ),
                      child: Text(
                        'Cancel visit',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
