import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import './gmeet.state.dart';

final gmeetReducer = combineReducers<GmeetState>(
    [forumInitReducer, forumInitSuccessReducer, forumInitFailureReducer]);

GmeetState forumInitReducer(GmeetState state, dynamic action) {
  GmeetState newState = state;

  if (action.type == 'GMEET_INIT') {
    newState = state.copyWith(loading: true, error: null, gmeetList: []);
  }

  return newState;
}

GmeetState forumInitSuccessReducer(GmeetState state, dynamic action) {
  GmeetState newState = state;
  if (action.type == 'GMEET_INIT_SUCCESS') {
    newState =
        state.copyWith(loading: false, error: null, gmeetList: action.payload);
  }

  return newState;
}

GmeetState forumInitFailureReducer(GmeetState state, dynamic action) {
  GmeetState newState = state;

  if (action.type == 'GMEET_INIT_FAILED') {
    newState =
        state.copyWith(loading: false, error: action.error, gmeetList: []);
  }

  return newState;
}
