import 'package:redux/redux.dart';
import 'package:sadulur/store/assessment/assessment.middleware.dart';
import 'package:sadulur/store/event/event.middleware.dart';
import 'package:sadulur/store/forum/forum.middleware.dart';
import 'package:sadulur/store/gmeet/gmeet.middleware.dart';
import 'package:sadulur/store/login/login.middleware.dart';
import 'package:sadulur/store/umkm_store/umkm_store.middleware.dart';
import './app.state.dart';

List<Middleware<AppState>> appMiddleware() {
//   final Middleware<AppState> _login = login(_repo);

  return [
    loginMiddleware,
    assessmentMiddleware,
    forumMiddleware,
    gmeetMiddleware,
    umkmMiddleware,
    eventMiddleware
  ];
}
