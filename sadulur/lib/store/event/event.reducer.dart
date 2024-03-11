import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/event.dart';
import 'package:sadulur/store/event/event.action.dart';
import './event.state.dart';

final eventReducer = combineReducers<EventState>([umkmStoreReducerAll]);

EventState umkmStoreReducerAll(EventState state, dynamic action) {
  EventState newState = state;

  if (action is GetAllEventAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is GetAllEventSuccessAction) {
    List<Event> past = action.payload["past"];
    List<Event> upcoming = action.payload["upcoming"];

    newState = state.copyWith(
        loading: false, error: null, pastEvent: past, upcomingEvent: upcoming);
  } else if (action is AddEventAction) {
    newState = state.copyWith(loading: true);
  } else if (action is AddEventSuccessAction) {
    List<Event> newUpcoming = List.from(state.upcomingEvent);
    newUpcoming.add(action.event);
    newState =
        state.copyWith(loading: false, error: null, upcomingEvent: newUpcoming);
  } else if (action is EventFailedAction) {
    newState = state.copyWith(loading: false, error: action.error);
  }
  return newState;
}
