import 'package:flutter/foundation.dart';
import 'package:sadulur/models/event.dart';

class EventState {
  final bool loading;
  final String error;
  final List<Event> pastEvent;
  final List<Event> upcomingEvent;

  EventState(
      {required this.loading,
      required this.error,
      required this.pastEvent,
      required this.upcomingEvent});

  factory EventState.initial() =>
      EventState(loading: false, error: '', pastEvent: [], upcomingEvent: []);

  EventState copyWith(
          {bool? loading,
          String? error,
          List<Event>? pastEvent,
          List<Event>? upcomingEvent}) =>
      EventState(
          loading: loading ?? this.loading,
          error: error ?? this.error,
          pastEvent: pastEvent ?? this.pastEvent,
          upcomingEvent: upcomingEvent ?? this.upcomingEvent);

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is EventState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          error == other.error &&
          listEquals(pastEvent, other.pastEvent) &&
          listEquals(upcomingEvent, other.upcomingEvent);

  @override
  int get hashCode =>
      super.hashCode ^ runtimeType.hashCode ^ loading.hashCode ^ error.hashCode;

  @override
  String toString() =>
      "EventState { loading: $loading,  error: $error, pastEvent: $pastEvent, upcomingEvent: $upcomingEvent }";
}
