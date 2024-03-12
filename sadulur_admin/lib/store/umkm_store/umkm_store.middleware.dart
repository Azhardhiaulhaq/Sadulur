import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sadulur_admin/store/app.state.dart';

Middleware<AppState> umkmMiddleware = (store, action, next) async {
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  // Pass the action to the next middleware or the reducer
  next(action);
};
