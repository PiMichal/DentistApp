class Event {
  final String documentId;
  final String email;
  final DateTime datetime;
  final bool status;

  Event({
    this.documentId = '',
    this.email = '',
    DateTime? dateTime,
    this.status = false,
  }) : datetime = dateTime ?? DateTime.now();

  String getTimeString() {
    return '${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}';
  }

  String getDateTimeString() {
    return '${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year} at ' +
        '${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}';
  }
}
