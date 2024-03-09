import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:sadulur/models/participant_list.dart';
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
      logger.d("Gmeet : ${documents} ");
      List<GoogleMeet> meets = documents.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return GoogleMeet(
            startTime: data['startTime'].toDate(),
            endTime: data['endTime'].toDate(),
            title: data['title'],
            description: data['description'],
            meetLink: data['meetLink'],
            attendees: List<String>.from(data['attendees'] ?? []));
      }).toList();

      FirebaseFirestore.instance
          .collection("participants")
          .get()
          .then((participantValue) {
        List<DocumentSnapshot> participantDocuments = participantValue.docs;
        List<ParticipantList> participantEmails =
            participantDocuments.map((document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          return ParticipantList(
              id: document.id,
              name: data['name'] ?? "",
              participants: List.from(data['participants'] ?? []));
        }).toList();
        Map<String, dynamic> payload = {
          "meets": meets,
          "participants": participantEmails
        };
        store.dispatch(GmeetInitSuccessAction(payload: payload));
      }).catchError((error) {
        logger.e(error.toString());
        store.dispatch(GmeetInitFailedAction(error: error.toString()));
      });
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(GmeetInitFailedAction(error: error.toString()));
    });
  } else if (action is AddMeetingAction) {
    FirebaseFirestore.instance.collection("coachings").add({
      "startTime": action.meet.startTime,
      "endTime": action.meet.endTime,
      "attendees": action.meet.attendees,
      "description": action.meet.description,
      "meetLink": action.meet.meetLink,
      "title": action.meet.title
    }).then((value) {
      store.dispatch(AddMeetingSuccessAction(payload: action.meet));
    }).catchError((error) {
      store.dispatch(AddMeetingFailedAction(error: error.toString()));
    });
  }

  // Pass the action to the next middleware or the reducer
  next(action);
};
