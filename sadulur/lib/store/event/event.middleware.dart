import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/event.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/event/event.action.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Middleware<AppState> eventMiddleware = (store, action, next) {
  if (action is GetAllEventAction) {
    List<Event> pastEvent = [];
    List<Event> upcomingEvent = [];

    FirebaseFirestore.instance
        .collection('events')
        .get()
        .then((querySnapshot) async {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      DateTime now = DateTime.now();

      for (var document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String author = "";
        if (data["author"] != null) {
          DocumentSnapshot authorSnapshot = await data['author'].get();
          author = authorSnapshot['username'];
        }

        Timestamp timestamp = data["date"];
        DateTime date = timestamp.toDate();
        Event event = Event(
          author: author,
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
    String downloadUrl = "";
    if (action.event.banner != null) {
      final file = action.event.banner;
      final fileName = basename(file!.path);
      final destination = 'banner_image/$fileName';
      final storageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(destination);
      // ignore: body_might_complete_normally_catch_error
      final uploadTask = storageRef.putFile(file).catchError((error) {
        store.dispatch(EventFailedAction(error: error));
      });
      uploadTask.whenComplete(() {}).then((value) async {
        downloadUrl = await value.ref.getDownloadURL();
      }).catchError((error) {
        store.dispatch(EventFailedAction(error: error.toString()));
      });
    }

    FirebaseFirestore.instance.collection('events').add({
      'author': FirebaseFirestore.instance
          .collection('users')
          .doc(action.event.author),
      'name': action.event.name,
      'description': action.event.description,
      'location': action.event.location,
      'link': action.event.link,
      'date': action.event.date,
      'contactPerson': action.event.contactPerson,
      'bannerImage': downloadUrl
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
