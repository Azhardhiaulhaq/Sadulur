import 'package:flutter/material.dart';

class GmeetAction {
  @override
  String toString() {
    return 'GmeetAction { }';
  }
}

class GmeetInitAction {
  final String type = "GMEET_INIT";
  final String email;
  GmeetInitAction({required this.email});

  @override
  String toString() {
    return 'GmeetInitAction { }';
  }
}

class GmeetInitSuccessAction {
  final type = "GMEET_INIT_SUCCESS";
  final dynamic payload;

  GmeetInitSuccessAction({required this.payload});
  @override
  String toString() {
    return 'GmeetInitSuccessAction { isSuccess: $payload }';
  }
}

class GmeetInitFailedAction {
  final type = "GMEET_INIT_FAILED";
  final String error;

  GmeetInitFailedAction({required this.error});

  @override
  String toString() {
    return 'GmeetFailedAction { error: $error }';
  }
}

class GmeetSuccessAction {
  final int isSuccess;

  GmeetSuccessAction({required this.isSuccess});
  @override
  String toString() {
    return 'GmeetSuccessAction { isSuccess: $isSuccess }';
  }
}

class GmeetFailedAction {
  final String error;

  GmeetFailedAction({required this.error});

  @override
  String toString() {
    return 'GmeetFailedAction { error: $error }';
  }
}
