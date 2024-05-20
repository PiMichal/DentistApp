import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  TimePicker({required this.selectedTime, required this.onTimeSelected});

  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: OutlinedButton(
        onPressed: () {
          showTimePicker(
            context: context,
            initialTime: _selectedTime,
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true,
                ),
                child: Theme(
                  data: ThemeData(
                    textTheme: TextTheme(
                      bodyLarge: TextStyle(
                          color: Colors.black), // Change color to black
                    ),
                  ),
                  child: child!,
                ),
              );
            },
          ).then((value) {
            if (value != null) {
              setState(() {
                _selectedTime = value;
              });
              widget.onTimeSelected(value);
            }
          });
        },
        child: Text(
          '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
