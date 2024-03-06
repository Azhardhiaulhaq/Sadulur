// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/secrets.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:sadulur/presentations/coaching/coaching_form_page.dart';
import 'package:sadulur/presentations/coaching/gmeet/gmeet_card.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/gmeet/gmeet.action.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;

class CoachingPage extends StatelessWidget {
  const CoachingPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CoachingPageViewModel>(
      converter: (Store<AppState> store) => _CoachingPageViewModel(
          gmeetList: store.state.gmeetState.gmeetList,
          isLoading: store.state.loginState.loading),
      onInit: (store) => store.dispatch(
          GmeetInitAction(email: store.state.loginState.user?.email ?? "")),
      builder: (BuildContext context, _CoachingPageViewModel viewModel) {
        return _ForumPageContent(
          title: title,
          isLoading: viewModel.isLoading,
          gmeetList: viewModel.gmeetList,
        );
      },
    );
  }
}

class _CoachingPageViewModel {
  final List<GoogleMeet> gmeetList;
  final bool isLoading;

  _CoachingPageViewModel({required this.gmeetList, required this.isLoading});
}

class _ForumPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final List<GoogleMeet> gmeetList;

  const _ForumPageContent(
      {required this.title, required this.isLoading, required this.gmeetList});

  @override
  _ForumPageContentState createState() => _ForumPageContentState();
}

class _ForumPageContentState extends State<_ForumPageContent> {
  @override
  Widget build(BuildContext context) {
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
                  screen: CoachingFormPage(), withNavBar: false);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black), // Search icon
            onPressed: () {
              // Add your functionality for the search icon here
            },
          ),
        ],
      ),
      body: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.only(bottom: 32),
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
