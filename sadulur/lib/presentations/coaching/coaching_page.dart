// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:sadulur/models/participant_list.dart';
import 'package:sadulur/presentations/coaching/coaching_form_page.dart';
import 'package:sadulur/presentations/coaching/meet/meet_card.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/gmeet/gmeet.action.dart';

class CoachingPage extends StatelessWidget {
  const CoachingPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CoachingPageViewModel>(
      converter: (Store<AppState> store) => _CoachingPageViewModel(
          gmeetList: store.state.gmeetState.gmeetList,
          participantList: store.state.gmeetState.participantList,
          isLoading: store.state.loginState.loading),
      onInit: (store) => store
          .dispatch(GmeetInitAction(email: store.state.loginState.user.email)),
      builder: (BuildContext context, _CoachingPageViewModel viewModel) {
        return _ForumPageContent(
          title: title,
          isLoading: viewModel.isLoading,
          gmeetList: viewModel.gmeetList,
          participantList: viewModel.participantList,
        );
      },
    );
  }
}

class _CoachingPageViewModel {
  final List<GoogleMeet> gmeetList;
  final bool isLoading;
  final List<ParticipantList> participantList;

  _CoachingPageViewModel(
      {required this.gmeetList,
      required this.isLoading,
      required this.participantList});
}

class _ForumPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final List<GoogleMeet> gmeetList;
  final List<ParticipantList> participantList;

  const _ForumPageContent(
      {required this.title,
      required this.isLoading,
      required this.gmeetList,
      required this.participantList});

  @override
  _ForumPageContentState createState() => _ForumPageContentState();
}

class _ForumPageContentState extends State<_ForumPageContent> {
  @override
  Widget build(BuildContext context) {
    logger.d(widget.gmeetList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 80.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sadulur',
              style: CustomTextStyles.appBarTitle1,
            ),
            Text(widget.title, style: CustomTextStyles.appBarTitle2),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black), // Plus icon
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: CoachingFormPage(
                    participantList: widget.participantList,
                  ),
                  withNavBar: false);
            },
          ),
        ],
      ),
      body: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ListView.builder(
              itemCount: widget.gmeetList.length,
              itemBuilder: (context, index) {
                return GoogleMeetCard(googleMeet: widget.gmeetList[index]);
              },
            ),
          )),
    );
  }
}
