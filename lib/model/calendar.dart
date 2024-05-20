import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/event_data.dart';
import 'package:registration/utilites/marker_builder.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
    Provider.of<EventData>(context, listen: false).loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventData>(
      builder: (context, eventData, _) {
        return TableCalendar(
          calendarBuilders: CalendarBuilders(markerBuilder: markersBuilder),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.white54),
          ),
          focusedDay: eventData.today,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030),
          eventLoader: eventData.getEventsForDay,
          rowHeight: 45,
          headerStyle: HeaderStyle(
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            outsideTextStyle: TextStyle(color: Colors.white),
            weekendTextStyle: TextStyle(
              color: Colors.white54,
            ),
          ),
          selectedDayPredicate: (day) => eventData.isDaySelected(day),
          onDaySelected: (selectedDay, focusedDay) {
            eventData.updateSelectedDay(selectedDay);
          },
        );
      },
    );
  }
}
