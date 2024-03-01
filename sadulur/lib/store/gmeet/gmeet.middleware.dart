import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/gmeet/gmeet.action.dart';

Middleware<AppState> gmeetMiddleware = (store, action, next) {
  if (action is GmeetInitAction) {
    logger.d("Gmeet : ${action.email} ");
    FirebaseFirestore.instance
        .collection('coachings')
        .where('attendees', arrayContains: action.email)
        .get()
        .then((querySnapshot) {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      List<GoogleMeet> meets = documents.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return GoogleMeet(
            startTime: data['startTime'].toDate(),
            endTime: data['endTime'].toDate(),
            title: data['title'],
            description: data['description'],
            location: data['location'],
            meetLink: data['meetLink'],
            attendees: List<String>.from(data['attendees'] ?? []));
      }).toList();
      store.dispatch(GmeetInitSuccessAction(payload: meets));
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(GmeetInitFailedAction(error: error.toString()));
    });
  }

  // Pass the action to the next middleware or the reducer
  next(action);
};
