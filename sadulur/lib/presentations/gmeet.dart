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
import 'package:sadulur/presentations/gmeet_form.dart';
import 'package:sadulur/presentations/widgets/gmeet/gmeet_card.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/gmeet/gmeet.action.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;

class GmeetPage extends StatelessWidget {
  const GmeetPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _GmeetPageViewModel>(
      converter: (Store<AppState> store) => _GmeetPageViewModel(
          gmeetList: store.state.gmeetState.gmeetList,
          isLoading: store.state.loginState.loading),
      onInit: (store) => store.dispatch(
          GmeetInitAction(email: store.state.loginState.user?.email ?? "")),
      builder: (BuildContext context, _GmeetPageViewModel viewModel) {
        return _ForumPageContent(
          title: title,
          isLoading: viewModel.isLoading,
          gmeetList: viewModel.gmeetList,
        );
      },
    );
  }
}

class _GmeetPageViewModel {
  final List<GoogleMeet> gmeetList;
  final bool isLoading;

  _GmeetPageViewModel({required this.gmeetList, required this.isLoading});
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
            onPressed: () async {
              var clientID = ClientId(Secret.ANDROID_SECRET_KEY, "");
              const scopes = [cal.CalendarApi.calendarScope];

              var accountCredentials = ServiceAccountCredentials.fromJson({
                "private_key_id": "8cd8f101fe7a4fe8e728178993569e52605c0076",
                "private_key":
                    "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDNUCb1dVu+QWnz\nQ9yBJXKZOIV+6yN9L0tt0JV7fFaDNkQcSxjBh1/qzD/IGGreTpkjOnjjN87p8a5c\nF0I9QB03gPBRwV2Y0pG7eQtakITSiqVEewF8pvbJPQuHM4WN+MvLrdkAnmlrdjIJ\nj7dszrxn9UROimwphvlVelGaPgmQk10YsbsF53tSCSZZg5Vc9s36uLRBdX1Ahqrt\nZLXsvEMgdfAv3M0QfSxHpxMiKVINTMwqHdRyeuXssEdm6QDRwRlCQ7jvbm48yJ76\n4OK/SfP+Y9hPFPGdesuyBII6oVcZeljNM5YY7c7kFgOP7nTGezp1QPAUFBsTjsPE\ni+k4f2PTAgMBAAECggEAEKsoto99tsxA9oPBNugo543VfL18LWr12nQ8QDQsiLOS\n3QjI+XFTSFDaMfviTt3q6rErflsAdmRtZ1zPpZrICtw+s1lNDx3m85iUsBiA+0aC\n7psQvr0f1qx/lc1V7I+EUCsMx2zINA+UNjJP57DZgZRbV6FyVzH2AGQRYVt9bRpi\n22xJOvsYCArcV1vUXDFs21RiDMwKp0PXkYHALCoHS1U+XhkQQGy0C6v0jBYbDy9l\nEuc1fs+80oFLzvttP/tiY8/H6C9fiPDqWY0c+GY8m6RoUA7lCCUbxUgdYAMP0Ew+\npOQbiT9QwqMElYYFH3hTz0YU3BvEku4p7BTL2lu0FQKBgQDscPyqi0U1282IBIc2\nfgNfJ/rlUvTt9H3/5Rx4Nw9HS8ZROax8b8PP4FIcjGXf53j9t7YhpiKR3hZ+uimG\nHBwjzCcQZ7QIGNdI2cGJ/KMljnrrgTxSwdymt3ILOKe0GbilVyGMi4V+yvJbvjOI\nzQ2OvXVLgWvE5eb4LBODmOyZxwKBgQDeS/nV/kg68nuXc2P0Sang8S0qDj+JPnOV\n2aipldV2yHkOC5Lq1qcBxIsEsxxFjmGYcGZIsQY61+AAMc4yI4oy/pkm/p0ng7r7\nhw749cR80BROhnRNqyBl2LXQ+E1uRxeoz9bJ2Mo6sJV318NyAYJWMgAl5ONIKup7\nyWpuwe8FlQKBgEoKu+UARgUutvdQS7Nx1MZ4s6Yay161ALwg2ECBJYSzIwCOqggx\ny8UOP0h3YvOx/f6eCCgTaaH6RVscGyLHLLy9EsKdZxBeDxTeNDBs7/4z1yRmzSgx\nU1LWAZ2n+UR6BYupdHUZwA1Lqoe2UVcWt5cql0+00LXRNPoke1vriLRDAoGAeSxZ\nB3kQznEXRbs0pRjybReKUv5pS9qrDugStD5kmdc1hZ5xe2l+p8wHK4ymwJOYR4wd\ndUpp5vF9vR1pFJOi5aE6wrLP35ZC+pDobHUrog2axCMuipfZlSrIER0IuDAwiWih\n4G037z4Ke8U1WJPSBEJFKmLWMaSTJN7qEW3NaPECgYAdpj5MHcyaHxD+MhULYUTH\nj/aR+uRo1i8hQk0fLqo+PyR/x36lWHKD1dB0ObKEVeZQp8O2izb71bNyAz0qL0zK\nBqcUwh03nYhKISelDCbdCp/uM1w76mViMRJVJtvYvttgRIQCUbJ1yFz76y8cG939\n3DndrHHGZMHryNwh/3f9HA==\n-----END PRIVATE KEY-----\n",
                "client_email": "umkm-application@appspot.gserviceaccount.com",
                "client_id": "113750975575868568566",
                "type": "service_account"
              });

              // await clientViaUserConsent(
              //     auth.ClientId(
              //         "508765405163-2dp1dvleqbbqp8u6nc4lrdseulmmsqj2.apps.googleusercontent.com",
              //         "Wdun-6-iwdOAE8nSs9OeoZqo"),
              //     scopes,
              //     prompt);

              // await clientViaUserConsent(clientID, scopes, prompt,
              //         hostedDomain: "localhost")
              //     .then(
              //   (value) {},
              // );
              await clientViaServiceAccount(accountCredentials, scopes)
                  .then((AuthClient client) {
                logger.d('Logged Client: $client');
                cal.CalendarApi calendar = cal.CalendarApi(client);

                cal.Event event = cal.Event();
                event.summary = "Test Event";
                event.description = "Test Description";
                cal.EventAttendee attendee = cal.EventAttendee(
                    displayName: "Azhar", email: "azhar@tantowi.com");
                event.attendees = [attendee];
                event.location = "Test Location";
                cal.EventDateTime start = new cal.EventDateTime();
                start.dateTime = DateTime.now();
                start.timeZone = "GMT+05:30";
                event.start = start;

                cal.EventDateTime end = new cal.EventDateTime();
                end.timeZone = "GMT+05:30";
                end.dateTime = DateTime.now();
                event.end = end;
                cal.ConferenceData conferenceData = cal.ConferenceData();
                cal.CreateConferenceRequest conferenceRequest =
                    cal.CreateConferenceRequest();

// A unique ID should be used for every separate video conference event
                conferenceRequest.requestId =
                    "${DateTime.now().millisecondsSinceEpoch}-123}";
                conferenceData.createRequest = conferenceRequest;

                event.conferenceData = conferenceData;
                calendar.events
                    .insert(event,
                        "7da6e5c8d9badd3a96e62ef6265a389d90b25b06ab732cd4a3eb2f01558e69f2@group.calendar.google.com")
                    .then((value) {})
                    .catchError((error) {
                  logger.e(error.toString());
                });

                // calendar.events
                //     .insert(event, "primary",
                //         conferenceDataVersion: 1, sendUpdates: "none")
                //     .then((value) {
                //   if (value.status == "confirmed") {
                //     String joiningLink;
                //     String eventId;

                //     eventId = value.id ?? "No ID";
                //     joiningLink =
                //         "https://meet.google.com/${value.conferenceData?.conferenceId}";

                //     var eventData = {'id': eventId, 'link': joiningLink};
                //     logger.d(eventData);
                //   }
                // }).catchError((error) {
                //   logger.e(error.toString());
                // });
              });
              // await clientViaUserConsent(clientID, scopes, prompt)
              //     .then((AuthClient client) async {
              //   cal.CalendarApi calendar = cal.CalendarApi(client);
              // });

              // PersistentNavBarNavigator.pushNewScreen(context,
              //     screen: GoogleMeetFormPage(), withNavBar: false);
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
