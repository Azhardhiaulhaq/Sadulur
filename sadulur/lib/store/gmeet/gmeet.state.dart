import 'package:flutter/foundation.dart';
import 'package:sadulur/models/google_meet.dart';

class GmeetState {
  final bool loading;
  final String error;
  final List<GoogleMeet> gmeetList;

  GmeetState(this.loading, this.error, this.gmeetList);

  factory GmeetState.initial() => GmeetState(false, '', []);

  GmeetState copyWith(
          {bool? loading, String? error, List<GoogleMeet>? gmeetList}) =>
      GmeetState(loading ?? this.loading, error ?? this.error,
          gmeetList ?? this.gmeetList);

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is GmeetState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          error == other.error &&
          listEquals(gmeetList, other.gmeetList);

  @override
  int get hashCode =>
      super.hashCode ^ runtimeType.hashCode ^ loading.hashCode ^ error.hashCode;

  @override
  String toString() =>
      "GmeetState { loading: $loading,  error: $error, gmeetList: $gmeetList}";
}
