import 'package:flutter/foundation.dart';

class AssessmentState {
  final bool loading;
  final String error;
  final List<String>? entreprenurialQuestions;

  AssessmentState(this.loading, this.error, this.entreprenurialQuestions);

  factory AssessmentState.initial() => AssessmentState(false, '', []);

  AssessmentState copyWith(
          {bool? loading,
          String? error,
          List<String>? entreprenurialQuestions}) =>
      AssessmentState(loading ?? this.loading, error ?? this.error,
          entreprenurialQuestions ?? this.entreprenurialQuestions);

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is AssessmentState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          error == other.error &&
          listEquals(entreprenurialQuestions, other.entreprenurialQuestions);

  @override
  int get hashCode =>
      super.hashCode ^ runtimeType.hashCode ^ loading.hashCode ^ error.hashCode;

  @override
  String toString() => "AssessmentState { loading: $loading,  error: $error}";
}
