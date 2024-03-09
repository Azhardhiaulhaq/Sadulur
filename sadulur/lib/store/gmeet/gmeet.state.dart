import 'package:flutter/foundation.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:sadulur/models/participant_list.dart';

class GmeetState {
  final bool loading;
  final String error;
  final List<GoogleMeet> gmeetList;
  final List<ParticipantList> participantList;

  GmeetState(this.loading, this.error, this.gmeetList, this.participantList);

  factory GmeetState.initial() => GmeetState(false, '', [], []);

  GmeetState copyWith(
          {bool? loading,
          String? error,
          List<GoogleMeet>? gmeetList,
          List<ParticipantList>? participantList}) =>
      GmeetState(loading ?? this.loading, error ?? this.error,
          gmeetList ?? this.gmeetList, participantList ?? this.participantList);

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is GmeetState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          error == other.error &&
          listEquals(gmeetList, other.gmeetList) &&
          listEquals(participantList, other.participantList);

  @override
  int get hashCode =>
      super.hashCode ^ runtimeType.hashCode ^ loading.hashCode ^ error.hashCode;

  @override
  String toString() =>
      "GmeetState { loading: $loading,  error: $error, gmeetList: $gmeetList}";
}
