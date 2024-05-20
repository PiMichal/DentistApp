import 'package:flutter/material.dart';
import 'package:registration/model/event.dart';
import 'package:provider/provider.dart';
import '../services/event_data.dart';
import 'package:registration/utilites/constants.dart';

class ShowEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<Event>>(
        valueListenable: Provider.of<EventData>(context).selectedEvents,
        builder: (context, value, _) {
          final eventData = Provider.of<EventData>(context);
          final selectedDayEvents = eventData.getEventsForDay(eventData.today);

          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView.builder(
              itemCount: selectedDayEvents.length,
              itemBuilder: (context, index) {
                final event = selectedDayEvents[index];
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      event.status &&
                              !eventData.checkIfTheUserHasAnAppointment()
                          ? showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: kShowModalBottomSheetStyle,
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Make an appointment on \n ${event.getDateTimeString()}',
                                        style: kAppointmentStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              eventData.updateEventStatus(
                                                event.documentId,
                                                false,
                                              );
                                              eventData.loadEvents();
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Make an appointment',
                                              style:
                                                  kTextMakeAppointmentButtonStyle,
                                            ),
                                            style: kMakeAppointmentButtonStyle,
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: kTextCancelButtonStyle,
                                            ),
                                            style: kCancelButtonStyle,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : null;
                    },
                    title: Center(
                      child: event.status
                          ? Text(
                              event.getTimeString(),
                              style: TextStyle(color: Colors.green),
                            )
                          : Text(
                              event.getTimeString(),
                              style: TextStyle(color: Colors.red),
                            ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
