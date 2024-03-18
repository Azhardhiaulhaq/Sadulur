import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/presentations/website/home/home_screen.dart';
import 'package:sadulur/presentations/widgets/navigation_bar.dart';
import 'package:sadulur/store/app.middleware.dart';
import 'package:sadulur/store/app.reducer.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/assessment/assessment.state.dart';
import 'package:sadulur/store/event/event.state.dart';
import 'package:sadulur/store/forum/forum.state.dart';
import 'package:sadulur/store/gmeet/gmeet.state.dart';
import 'package:sadulur/store/login/login.state.dart';
import 'package:sadulur/store/umkm_store/umkm_store.state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';

var logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final Store<AppState> store = Store<AppState>(appReducer,
      initialState: AppState(
          isLoading: false,
          assessmentState: AssessmentState.initial(),
          loginState: LoginState.initial(),
          forumState: ForumState.initial(),
          gmeetState: GmeetState.initial(),
          umkmStoreState: UmkmStoreState.initial(),
          eventState: EventState.initial()), // Initial state
      middleware: appMiddleware());

  runApp(MyApp(store: store));
}

void prompt(String url) async {
  url =
      "https://accounts.google.com/o/oauth2/v2/auth?client_id=508765405163-moo7plbapuvfistd6ihha8sg56kdstmh.apps.googleusercontent.com&response_type=code&redirect_uri=http%3A%2F%2F127.0.0.1%3A44967&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar&code_challenge=aKpJEwt1yTkQADKYHPzkmnFSDZ9OHc1zRVUxKGeGlJ0&code_challenge_method=S256&hd=127.0.0.1&state=jVdBNzV1Hy41LI9HlwhntG5MWNRSd-9Y";
  Uri parsedUrl = Uri.parse(url);
  if (await canLaunchUrl(parsedUrl)) {
    await launchUrl(parsedUrl);
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.white,
        ),
        home: StoreConnector<AppState, bool>(
          converter: (store) => store.state.loginState.isLoggedIn,
          builder: (context, isLoggedIn) {
            if (kIsWeb) {
              return HomeScreen();
            } else {
              // if (isLoggedIn) {
              return BottomNavigation(
                  menuScreenContext: context,
                  user: store.state.loginState.user);
              // } else {
              //   return const LoginPage(title: "Login Page");
              // }
            }
          },
        ),
      ),
    );
  }
}
