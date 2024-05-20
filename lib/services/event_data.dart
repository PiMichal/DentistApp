import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:registration/model/event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventData extends ChangeNotifier {
  List<Event> _events = [];
  User? user = FirebaseAuth.instance.currentUser;
  ValueNotifier<List<Event>> _selectedEvents = ValueNotifier<List<Event>>([]);

  DateTime _today = DateTime.now();

  DateTime get today => _today;

  set today(DateTime value) {
    _today = value;
    notifyListeners();
  }

  ValueNotifier<List<Event>> get selectedEvents => _selectedEvents;

  List<Event> getEventsForDay(DateTime day) {
    return _events.where((event) => isSameDay(event.datetime, day)).toList();
  }

  bool isDaySelected(DateTime day) {
    return isSameDay(day, _today);
  }

  void updateSelectedDay(DateTime selectedDay) {
    _today = selectedDay;
    notifyListeners();
  }

  Future<void> updateEventStatus(String eventId, bool newStatus) async {
    try {
      await FirebaseFirestore.instance.collection('visits').doc(eventId).update(
        {
          'status': newStatus,
          'email': !newStatus ? user?.email : "",
        },
      );

      notifyListeners();
    } catch (e) {
      print("Error updating event status: $e");
    }
  }

  Future<void> editEvent(
      {required String eventId,
      required DateTime date,
      required TimeOfDay time}) async {
    DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    try {
      await FirebaseFirestore.instance.collection('visits').doc(eventId).update(
        {
          'datetime': dateTime,
        },
      );
      notifyListeners();
    } catch (e) {
      print("Error editing event: $e");
    }
  }

  Future<void> addEvent(
      {required DateTime date, required TimeOfDay time}) async {
    DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    try {
      await FirebaseFirestore.instance.collection('visits').add(
        {
          'datetime': dateTime,
          'email': "",
          'status': true,
        },
      );
      notifyListeners();
    } catch (e) {
      print("Error adding event: $e");
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseFirestore.instance
          .collection('visits')
          .doc(eventId)
          .delete();
      notifyListeners();
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  Future<void> loadEvents() async {
    try {
      _events.clear();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('visits')
          .where('status')
          .orderBy('datetime')
          .get();
      _events = querySnapshot.docs.map((doc) {
        String documentId = doc.id;
        String email = doc['email'];
        DateTime datetime = (doc['datetime'] as Timestamp).toDate();
        bool status = doc['status'];
        return Event(
          documentId: documentId,
          email: email,
          dateTime: datetime,
          status: status,
        );
      }).toList();
      _selectedEvents.value = _events;

      notifyListeners();
    } catch (e) {
      print('Error loading events: $e');
    }
  }

  Future<void> deleteExpiredDocuments() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('visits')
          .where('datetime', isLessThan: Timestamp.now())
          .get();

      querySnapshot.docs.forEach(
        (doc) {
          doc.reference.delete();
        },
      );
    } catch (e) {
      print("Error deleting expired document: $e");
    }
  }

  bool checkIfTheUserHasAnAppointment() {
    return _events.any((event) => event.email == user?.email);
  }

  Event? getEventsForUser() {
    return _events.firstWhere(
      (event) => event.email == user?.email,
      orElse: () => Event(),
    );
  }
}
