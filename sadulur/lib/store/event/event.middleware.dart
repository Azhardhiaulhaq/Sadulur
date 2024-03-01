import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/event.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/event/event.action.dart';

Middleware<AppState> eventMiddleware = (store, action, next) {
  if (action is GetAllEventAction) {
    List<Event> pastEvent = [];
    List<Event> upcomingEvent = [];

    FirebaseFirestore.instance.collection('events').get().then((querySnapshot) {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      DateTime now = DateTime.now();

      for (var document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        Timestamp timestamp = data["date"];
        DateTime date = timestamp.toDate();
        Event event = Event(
          author: data["author"] ?? "No Author",
          id: document.id,
          name: data['name'] ?? "No Event Name",
          description: data['description'] ?? "No Description",
          bannerImage: data['bannerImage'],
          location: data['location'] ?? "No Location",
          link: data['link'],
          date: date,
          contactPerson: data['contactPerson'] ?? "No Contact Person",
        );

        if (date.isBefore(now)) {
          pastEvent.add(event);
        } else {
          upcomingEvent.add(event);
        }
      }

      store.dispatch(GetAllEventSuccessAction(
          payload: {"past": pastEvent, "upcoming": upcomingEvent}));
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(EventFailedAction(error: error.toString()));
    });
  } else if (action is AddEventAction) {
    FirebaseFirestore.instance.collection('events').add({
      'author': FirebaseFirestore.instance
          .collection('users')
          .doc(action.event.author),
      'name': action.event.name,
      'description': action.event.description,
      'location': action.event.location,
      'link': action.event.link,
      'date': action.event.date,
      'contactPerson': action.event.contactPerson
    }).then((value) {
      Event addedEvent = action.event.copyWith(id: value.id);
      store.dispatch(AddEventSuccessAction(event: addedEvent));
    }).catchError((error) {
      store.dispatch(EventFailedAction(error: error.toString()));
    });
  }

  // Pass the action to the next middleware or the reducer
  next(action);
};
