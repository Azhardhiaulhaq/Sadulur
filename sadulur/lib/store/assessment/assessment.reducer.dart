import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/store/assessment/assessment.action.dart';
import './assessment.state.dart';

final assessmentReducer =
    combineReducers<AssessmentState>([assessmentStoreReducerAll]);

AssessmentState assessmentStoreReducerAll(
    AssessmentState state, dynamic action) {
  AssessmentState newState = state;

  if (action is AssessmentAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is GetEntreprenurialAssessmentAction) {
    newState =
        state.copyWith(loading: true, error: null, entreprenurialQuestions: []);
  } else if (action is AssessmentFailedAction) {
    newState = state.copyWith(loading: false, error: action.error);
  } else if (action is GetEntreprenurialAssessmentSuccessAction) {
    newState = state.copyWith(
        loading: false, error: null, entreprenurialQuestions: action.questions);
  } else if (action is AddEntreprenurialAssessmentAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is AddEntreprenurialAssessmentSuccessAction) {
    newState = state.copyWith(loading: false, error: null);
  } else if (action is AddBasicAssessmentAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is AddBasicAssessmentSuccessAction) {
    newState = state.copyWith(loading: false, error: null);
  } else if (action is UpdateCategoryAssessmentAction) {
    newState = state.copyWith(loading: false, error: null);
  } 
  return newState;
}
