import 'package:sadulur/store/assessment/assessment.reducer.dart';
import 'package:sadulur/store/event/event.reducer.dart';
import 'package:sadulur/store/forum/forum.reducer.dart';
import 'package:sadulur/store/gmeet/gmeet.reducer.dart';
import 'package:sadulur/store/umkm_store/umkm_store.reducer.dart';

import './login/login.reducer.dart';

import './app.state.dart';

AppState appReducer(AppState state, action) => AppState(
    isLoading: false,
    assessmentState: assessmentReducer(state.assessmentState, action),
    loginState: loginReducer(state.loginState, action),
    forumState: forumReducer(state.forumState, action),
    gmeetState: gmeetReducer(state.gmeetState, action),
    umkmStoreState: umkmstoreReducer(state.umkmStoreState, action),
    eventState: eventReducer(state.eventState, action));
