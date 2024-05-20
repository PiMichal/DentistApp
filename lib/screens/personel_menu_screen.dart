import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration/services/event_data.dart';
import 'package:registration/widgets/reusable_appbar.dart';
import 'package:provider/provider.dart';
import 'package:registration/utilites/constants.dart';
import 'package:registration/model/calendar.dart';
import 'package:registration/model/personel_show_events.dart';
import 'package:registration/model/date_picker.dart';
import 'package:registration/model/time_picker.dart';

class PersonelMenuScreen extends StatefulWidget {
  @override
  State<PersonelMenuScreen> createState() => _PersonelMenuScreenState();
}

class _PersonelMenuScreenState extends State<PersonelMenuScreen> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    Provider.of<EventData>(context, listen: false).deleteExpiredDocuments();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
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
                "Admin panel",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Calendar(),
              PersonelShowEvents(),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                backgroundColor: Colors.lightBlueAccent,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: kShowModalBottomSheetStyle,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Date:"),
                            DatePicker(
                              selectedDate: DateTime.now(),
                              onDateSelected: (DateTime date) {
                                setState(() {
                                  _selectedDate = date;
                                });
                              },
                            ),
                            Text("Time:"),
                            TimePicker(
                              selectedTime: TimeOfDay.now(),
                              onTimeSelected: (TimeOfDay time) {
                                setState(() {
                                  _selectedTime = time;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Colors.green,
                                ),
                              ),
                              onPressed: () {
                                eventData.addEvent(
                                    date: _selectedDate, time: _selectedTime);
                                eventData.loadEvents();
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Add new visit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
