import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/google_meet.dart';
import './gmeet.state.dart';

final gmeetReducer = combineReducers<GmeetState>(
    [forumInitReducer, forumInitSuccessReducer, forumInitFailureReducer]);

GmeetState forumInitReducer(GmeetState state, dynamic action) {
  GmeetState newState = state;

  if (action.type == 'GMEET_INIT') {
    newState = state.copyWith(loading: true, error: null, gmeetList: []);
  } else if (action.type == 'ADD_MEETING_ACTION') {
    newState = state.copyWith(loading: true, error: null, gmeetList: []);
  }

  return newState;
}

GmeetState forumInitSuccessReducer(GmeetState state, dynamic action) {
  GmeetState newState = state;
  if (action.type == 'GMEET_INIT_SUCCESS') {
    newState = state.copyWith(
        loading: false,
        error: null,
        gmeetList: action.payload["meets"],
        participantList: action.payload["participants"]);
  } else if (action.type == "ADD_MEETING_SUCCESS_ACTION") {
    List<GoogleMeet> newList = state.gmeetList;
    newList.add(action.payload);
    newState = state.copyWith(loading: false, error: null, gmeetList: newList);
  }

  return newState;
}

GmeetState forumInitFailureReducer(GmeetState state, dynamic action) {
  GmeetState newState = state;

  if (action.type == 'GMEET_INIT_FAILED') {
    newState =
        state.copyWith(loading: false, error: action.error, gmeetList: []);
  } else if (action.type == 'ADD_MEETING_FAILED_ACTION') {
    newState = state.copyWith(loading: false, error: action.error);
  }

  return newState;
}
