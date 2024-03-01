import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/event.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/event/event_card.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/event/event.action.dart';

class EventPage extends StatelessWidget {
  final String title;

  const EventPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _EventPageViewModel>(
      converter: (Store<AppState> store) => _EventPageViewModel(
          error: store.state.eventState.error,
          isLoading: store.state.eventState.loading,
          user: store.state.loginState.user,
          pastEvent: store.state.eventState.pastEvent,
          upcomingEvent: store.state.eventState.upcomingEvent),
      onInit: (store) {
        store.dispatch(GetAllEventAction());
      },
      builder: (BuildContext context, _EventPageViewModel viewModel) {
        return _EventPageContent(
          title: title,
          isLoading: viewModel.isLoading,
          user: viewModel.user,
          pastEvent: viewModel.pastEvent,
          upcomingEvent: viewModel.upcomingEvent,
        );
      },
    );
  }
}

class _EventPageViewModel {
  final String error;
  final bool isLoading;
  final UMKMUser user;
  final List<Event> pastEvent;
  final List<Event> upcomingEvent;

  _EventPageViewModel(
      {required this.error,
      required this.isLoading,
      required this.pastEvent,
      required this.user,
      required this.upcomingEvent});
}

class _EventPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;
  final List<Event> pastEvent;
  final List<Event> upcomingEvent;

  const _EventPageContent(
      {required this.title,
      required this.isLoading,
      required this.user,
      required this.pastEvent,
      required this.upcomingEvent});

  @override
  _EventPageContentState createState() => _EventPageContentState();
}

class _EventPageContentState extends State<_EventPageContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            toolbarHeight: 80.0,
            actions: [
              widget.user.isAdmin
                  ? IconButton(
                      icon: const Icon(Icons.add, color: AppColor.darkDatalab),
                      onPressed: () {
                        Navigator.pushNamed(context, '/event/add',
                            arguments: {});
                      },
                    )
                  : Container(),
            ],
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sadulur',
                  style: CustomTextStyles.appBarTitle1,
                ),
                Text(
                  widget.title,
                  style: CustomTextStyles.appBarTitle2,
                ),
              ],
            ),
            bottom: TabBar(
              indicatorPadding: EdgeInsets.zero,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.darkDatalab),
              labelColor: AppColor.secondaryTextDatalab,
              unselectedLabelColor: AppColor.textDatalab,
              tabs: const [
                SizedBox(
                  width: double.infinity,
                  child: Tab(text: "Past Events"),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Tab(text: "Upcoming Events"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AlignedGridView.count(
                crossAxisCount: 1,
                itemCount: widget.pastEvent.length,
                itemBuilder: (BuildContext context, int index) {
                  return EventCard(
                      event: widget.pastEvent[index], isExpired: true);
                },
              ),
              AlignedGridView.count(
                crossAxisCount: 1,
                itemCount: widget.upcomingEvent.length,
                itemBuilder: (BuildContext context, int index) {
                  return EventCard(
                      event: widget.upcomingEvent[index], isExpired: false);
                },
              )
            ],
          )),
    );
  }
}
