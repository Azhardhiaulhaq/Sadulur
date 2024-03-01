import 'package:flutter/material.dart';
import 'package:sadulur/models/event.dart';

class EventAction {
  @override
  String toString() {
    return 'EventAction { }';
  }
}

class GetAllEventAction {
  final String type = "GET_ALL_EVENT_ACTION";
  GetAllEventAction();

  @override
  String toString() {
    return 'GetAllEventAction';
  }
}

class GetAllEventSuccessAction {
  final String type = "GET_ALL_EVENT_SUCCESS_ACTION";
  final dynamic payload;
  GetAllEventSuccessAction({required this.payload});

  @override
  String toString() {
    return 'GetAllEventSuccessAction { payload: $payload }';
  }
}

class AddEventAction {
  final String type = "ADD_EVENT_ACTION";
  final Event event;
  AddEventAction({required this.event});
}

class AddEventSuccessAction {
  final String type = "ADD_EVENT_SUCCESS_ACTION";
  final Event event;
  AddEventSuccessAction({required this.event});
}

class EventSuccessAction {
  final int isSuccess;

  EventSuccessAction({required this.isSuccess});
  @override
  String toString() {
    return 'EventSuccessAction { isSuccess: $isSuccess }';
  }
}

class EventFailedAction {
  final String error;

  EventFailedAction({required this.error});

  @override
  String toString() {
    return 'EventFailedAction { error: $error }';
  }
}
