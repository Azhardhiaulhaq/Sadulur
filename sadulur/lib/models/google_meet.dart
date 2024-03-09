import 'dart:core';

class GoogleMeet {
  final DateTime startTime;
  final DateTime endTime;
  final String title;
  final String description;
  final String meetLink;
  final List<String> attendees;

  GoogleMeet(
      {required this.startTime,
      required this.endTime,
      required this.title,
      required this.description,
      required this.meetLink,
      required this.attendees});
}
