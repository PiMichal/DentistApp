import 'package:flutter/material.dart';
import 'package:registration/model/event.dart';

Widget? markersBuilder(
    BuildContext context, DateTime date, List<dynamic> events) {
  final statusEvents =
      events.where((event) => event is Event && event.status).toList();
  final statusCount = statusEvents.length;

  if (statusCount > 0) {
    return Positioned(
      right: 1,
      bottom: 1,
      child: Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Text(
          '$statusCount',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  } else {
    return null;
  }
}
