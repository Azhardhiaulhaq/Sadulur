import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sadulur_admin/core/color_constants.dart';
import 'package:sadulur_admin/firebase_options.dart';
import 'package:sadulur_admin/presentation/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Your web app's Firebase configuration
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCFuy4x9iDcgGToqUV-GJHGXZgrk683GsA",
            authDomain: "sadulur-5ce5e.firebaseapp.com",
            projectId: "sadulur-5ce5e",
            storageBucket: "sadulur-5ce5e.appspot.com",
            messagingSenderId: "942885767569",
            appId: "1:942885767569:web:85993f841876866c02f230"));
  }
  // const firebaseConfig = {
  //   apiKey: "AIzaSyCFuy4x9iDcgGToqUV-GJHGXZgrk683GsA",
  //   authDomain: "sadulur-5ce5e.firebaseapp.com",
  //   projectId: "sadulur-5ce5e",
  //   storageBucket: "sadulur-5ce5e.appspot.com",
  //   messagingSenderId: "942885767569",
  //   appId: "1:942885767569:web:85993f841876866c02f230"
  // };

// Initialize Firebase
  // const app = initializeApp(firebaseConfig);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Dashboard - Admin Panel v0.1 ',
        theme: ThemeData.dark().copyWith(
          appBarTheme:
              const AppBarTheme(backgroundColor: bgColor, elevation: 0),
          scaffoldBackgroundColor: bgColor,
          primaryColor: greenColor,
          dialogBackgroundColor: secondaryColor,
          // buttonColor: greenColor,
          // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
          //     .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: HomeScreen());
  }
}
