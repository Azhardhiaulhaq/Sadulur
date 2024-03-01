import 'package:sadulur/store/assessment/assessment.state.dart';
import 'package:sadulur/store/event/event.state.dart';
import 'package:sadulur/store/forum/forum.state.dart';
import 'package:sadulur/store/gmeet/gmeet.state.dart';
import 'package:sadulur/store/umkm_store/umkm_store.state.dart';

import './login/login.state.dart';

import 'package:flutter/material.dart';

class AppState {
  final LoginState loginState;
  final bool isLoading;
  final AssessmentState assessmentState;
  final ForumState forumState;
  final GmeetState gmeetState;
  final UmkmStoreState umkmStoreState;
  final EventState eventState;

  AppState(
      {required this.isLoading,
      required this.assessmentState,
      required this.loginState,
      required this.forumState,
      required this.gmeetState,
      required this.umkmStoreState,
      required this.eventState});

  factory AppState.initial() => AppState(
      isLoading: false,
      assessmentState: AssessmentState.initial(),
      loginState: LoginState.initial(),
      forumState: ForumState.initial(),
      gmeetState: GmeetState.initial(),
      umkmStoreState: UmkmStoreState.initial(),
      eventState: EventState.initial());

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          loginState == other.loginState &&
          eventState == other.eventState;

  @override
  int get hashCode => super.hashCode ^ loginState.hashCode;

  @override
  String toString() {
    return "AppState { loginState: $loginState }";
  }
}
