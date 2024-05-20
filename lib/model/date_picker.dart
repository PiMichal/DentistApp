import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  DatePicker({required this.selectedDate, required this.onDateSelected});

  final Function(DateTime) onDateSelected;
  final DateTime selectedDate;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: OutlinedButton(
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          ).then((value) {
            if (value != null) {
              setState(() {
                _selectedDate = value;
              });
              widget.onDateSelected(value);
            }
          });
        },
        child: Text(
          '${_selectedDate.day.toString().padLeft(2, '0')}.${_selectedDate.month.toString().padLeft(2, '0')}.${_selectedDate.year}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
