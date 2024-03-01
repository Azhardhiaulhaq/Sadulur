import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColor {
  AppColor._();
  static const Color blueColor = Color(0xFF2F39C5);
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );
  static const Color backgroundGrey = Color(0xFFEFF1F3);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color darkGreen = Color(0xff2D6B22);
  static const Color darkRed = Color(0xff460000);
  static const Color darkOrange = Color(0xffe47d00);
  static const Color sbmlightBlue = Color(0xff06D2FF);
  static const Color sbmdarkBlue = Color(0xff0078C9);
  static const Color textfieldBG = Color(0xfff3f3f4);
  static const Color lightgreyBG = Color(0xffE1E2E4);
  static const Color lightBluePastelBG = Color(0x1206D2FF);
  static const Color darkDatalab = Color(0xff141C2B);
  static const Color textDatalab = Color(0xff222f49);
  static const Color backgroundDatalab = Color(0xfff8fafc);
  static const Color secondaryTextDatalab = Color(0xffe0b564);
  static const Color successNotification = Color(0xff64bc26);
  static const Color failedNotification = Color(0xffea1601);
  static const Color warningNotification = Color(0xfffad202);
  static const Color deadlineRed = Color(0xffD8212B);
  static const Color greenText = Color(0xff5DB765);
  static const Color lightGrey = Color(0xffE4E4E4);
  static const Color darkGrey = Color.fromARGB(255, 178, 174, 174);
  static const Color redEmail = Color(0xffFF0000);
  static const Color black = Colors.black;
  static const Color blueFacebook = Color(0xff4267B2);
  static const Color likedIcon = Color(0xff2C78C2);
  static Color flushbarErrorBG = Colors.red[300]!;
  static Color flushbarSuccessBG = Colors.green[300]!;
}
