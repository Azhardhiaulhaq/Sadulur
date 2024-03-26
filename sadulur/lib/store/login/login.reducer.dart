import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/models/user_assessment.dart';
import 'package:sadulur/store/assessment/assessment.action.dart';
import 'package:sadulur/store/forum/forum.action.dart';
import 'package:sadulur/store/login/login.action.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';
import './login.state.dart';

final loginReducer = combineReducers<LoginState>([
  loginRequestReducer,
  loginSuccessReducer,
  loginFailureReducer,
]);

LoginState loginRequestReducer(LoginState state, dynamic action) {
  LoginState newState = state;

  if (action is LoginAction) {
    newState = state.copyWith(
        loading: true, error: null, isLoggedIn: null, user: null);
  } else if (action is RegistrationAction) {
    newState = state.copyWith(
        loading: true, error: null, isLoggedIn: null, user: null);
  }

  return newState;
}

LoginState loginSuccessReducer(LoginState state, dynamic action) {
  LoginState newState = state;
  if (action is LoginSuccessAction) {
    newState = state.copyWith(
        loading: false, error: null, isLoggedIn: true, user: action.payload);
  } else if (action is RegistrationSuccessAction) {
    newState = state.copyWith(
        loading: false, error: null, isLoggedIn: true, user: action.payload);
  } else if (action is GetUserDetailSuccessAction) {
    newState = state.copyWith(loading: false, error: null, user: action.user);
  } else if (action is LikePostActionSuccess ||
      action is LikePostReplyActionSuccess) {
    UMKMUser? newUser = state.user;

    newUser.addLikedPost(action.payload);

    newState = state.copyWith(user: newUser);
  } else if (action is UnLikePostActionSuccess ||
      action is UnlikePostReplyActionSuccess) {
    UMKMUser newUser = state.user;
    newUser.likedPost.remove(action.payload);
    newState = state.copyWith(user: newUser);
  } else if (action is AddEntreprenurialAssessmentSuccessAction) {
    UserAssessment newAssessment = UserAssessment(
        entrepreneurialAssessment: action.payload["assessment"],
        basicAssessment: state.user.assessment.basicAssessment);

    UMKMUser newUser = state.user.copyWith(
        assessment: newAssessment, updatedAt: action.payload["updatedAt"]);

    newState = state.copyWith(user: newUser);

    // newState = state.copyWith(user: action.payload);
  } else if (action is GetEntreprenurialAssessmentSuccessAction) {
    UserAssessment newAssessment = UserAssessment(
        entrepreneurialAssessment: action.entAssessment,
        basicAssessment: state.user.assessment.basicAssessment);
    UMKMUser? newUser = state.user.copyWith(assessment: newAssessment);
    newState = state.copyWith(user: newUser);
  } else if (action is GetCategoryAssessmentSuccessAction) {
    var assessment = CategoryAssessment.empty();

    if (action.categoryAssessment.isNotEmpty) {
      assessment =
          action.categoryAssessment[action.categoryAssessment.length - 1];
      logger.d("Login Reducer: ${action.categoryAssessment}");
    }
    UserAssessment userAssessment =
        state.user.assessment.copyWith(basicAssessment: assessment);
    UMKMUser? newUser = state.user.copyWith(assessment: userAssessment);
    newState = state.copyWith(user: newUser);
  } else if (action is UpdateCategoryAssessmentSuccessAction) {
    UserAssessment newAssessment = UserAssessment(
        entrepreneurialAssessment:
            state.user.assessment.entrepreneurialAssessment,
        basicAssessment: action.payload['assessment']);
    UMKMStore newStore =
        state.user.store.copyWith(level: action.payload['level']);
    UMKMUser newUser = state.user.copyWith(
        assessment: newAssessment, updatedAt: DateTime.now(), store: newStore);
    newState = state.copyWith(user: newUser);
  } else if (action is GetUmkmStoreDetailSuccessAction) {
    UMKMUser newUser = state.user.copyWith(store: action.payload.store);
    newState = state.copyWith(loading: false, error: null, user: newUser);
  } else if (action is UpdateUMKMPictureSuccessAction) {
    // state.storeDetail?.changePhotoProfile(action.downloadUrl);
    UMKMUser newUser = state.user.copyWith(store: action.store);
    newState = state.copyWith(loading: false, error: null, user: newUser);
  } else if (action is UpdateUMKMStoreInfoSuccessAction) {
    newState = state.copyWith(loading: false, error: null, user: action.user);
  } else if (action is AddBasicAssessmentSuccessAction) {
    UMKMUser newUser = state.user.copyWith(store: action.payload);
    newState = state.copyWith(loading: false, error: null, user: newUser);
  }

  return newState;
}

LoginState loginFailureReducer(LoginState state, dynamic action) {
  LoginState newState = state;

  if (action is LoginFailedAction) {
    newState = state.copyWith(
        loading: false, error: action.error, isLoggedIn: false, user: null);
  } else if (action is RegistrationFailedAction) {
    newState = state.copyWith(
        loading: false, error: action.error, isLoggedIn: false, user: null);
  }

  return newState;
}
