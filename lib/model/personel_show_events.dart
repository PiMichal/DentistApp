import 'package:flutter/material.dart';
import 'package:registration/model/event.dart';
import 'package:provider/provider.dart';
import '../services/event_data.dart';
import 'package:registration/utilites/constants.dart';
import 'package:registration/model/date_picker.dart';
import 'package:registration/model/time_picker.dart';

class PersonelShowEvents extends StatefulWidget {
  @override
  State<PersonelShowEvents> createState() => _PersonelShowEventsState();
}

class _PersonelShowEventsState extends State<PersonelShowEvents> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

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
                      setState(() {
                        _selectedDate = event.datetime;
                        _selectedTime = TimeOfDay.fromDateTime(event.datetime);
                      });
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: kShowModalBottomSheetStyle,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  '${event.getDateTimeString()}',
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
                                        Navigator.pop(context);
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              decoration:
                                                  kShowModalBottomSheetStyle,
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Date:'),
                                                  DatePicker(
                                                    selectedDate: _selectedDate,
                                                    onDateSelected:
                                                        (DateTime date) {
                                                      setState(() {
                                                        _selectedDate = date;
                                                      });
                                                    },
                                                  ),
                                                  Text('Time:'),
                                                  TimePicker(
                                                    selectedTime: _selectedTime,
                                                    onTimeSelected:
                                                        (TimeOfDay time) {
                                                      setState(() {
                                                        _selectedTime = time;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(height: 10),
                                                  FilledButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                        Colors.green,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      eventData.editEvent(
                                                        eventId:
                                                            event.documentId,
                                                        date: _selectedDate,
                                                        time: _selectedTime,
                                                      );
                                                      eventData.loadEvents();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Save',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Edit',
                                        style: kEditTextStyle,
                                      ),
                                      style: kEditButtonStyle,
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        eventData.deleteEvent(event.documentId);
                                        eventData.loadEvents();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Delete',
                                        style: kTextCancelButtonStyle,
                                      ),
                                      style: kCancelButtonStyle,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    title: Center(
                      child: event.status
                          ? Text(
                              event.getTimeString(),
                              style: TextStyle(color: Colors.green),
                            )
                          : Text(
                              "You have a visit with: ${event.email} at ${event.getTimeString()}",
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
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
