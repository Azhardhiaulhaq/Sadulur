import 'package:flutter/foundation.dart';
import 'package:sadulur/models/category_assessment.dart';

class AssessmentState {
  final bool loading;
  final String error;
  final List<String>? entreprenurialQuestions;
  final List<CategoryAssessment>? assessmentList;

  AssessmentState(this.loading, this.error, this.entreprenurialQuestions,
      this.assessmentList);

  factory AssessmentState.initial() => AssessmentState(false, '', [], []);

  AssessmentState copyWith(
          {bool? loading,
          String? error,
          List<String>? entreprenurialQuestions,
          List<CategoryAssessment>? assessmentList}) =>
      AssessmentState(
          loading ?? this.loading,
          error ?? this.error,
          entreprenurialQuestions ?? this.entreprenurialQuestions,
          assessmentList ?? this.assessmentList);

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
