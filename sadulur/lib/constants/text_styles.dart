import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sadulur/constants/colors.dart';

class CustomTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  static TextStyle appBarTitle1 = GoogleFonts.playfairDisplay(
    textStyle: const TextStyle(
      color: AppColor.darkDatalab,
      fontWeight: FontWeight.bold,
      fontSize: 20.0, // Adjust the font size if needed
    ),
  );

  static TextStyle appBarTitle2 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      color: AppColor.secondaryTextDatalab,
      fontWeight: FontWeight.normal, // You can adjust the font weight
      fontSize: 16.0, // Adjust the font size if needed
    ),
  );

  static TextStyle formText1 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      color: AppColor.darkDatalab,
      fontWeight: FontWeight.w300, // You can adjust the font weight
      fontSize: 14.0, // Adjust the font size if needed
    ),
  );

  static TextStyle formBoldText1 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      color: AppColor.darkDatalab,
      fontWeight: FontWeight.bold, // You can adjust the font weight
      fontSize: 16.0, // Adjust the font size if needed
    ),
  );

  static TextStyle buttonText2 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      color: AppColor.secondaryTextDatalab,
      fontWeight: FontWeight.bold, // You can adjust the font weight
      fontSize: 16.0, // Adjust the font size if needed
    ),
  );

  static TextStyle iconText1 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      color: AppColor.darkGrey,
      fontWeight: FontWeight.w300, // You can adjust the font weight
      fontSize: 12.0, // Adjust the font size if needed
    ),
  );

  static TextStyle tagText1 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      color: AppColor.backgroundWhite,
      fontWeight: FontWeight.bold, // You can adjust the font weight
      fontSize: 12.0, // Adjust the font size if needed
    ),
  );

  static TextStyle normalText(
          {Color? color = AppColor.textDatalab,
          double? fontSize = 14.0,
          FontWeight? fontWeight = FontWeight.normal}) =>
      GoogleFonts.roboto(
          textStyle: TextStyle(
              color: color, fontSize: fontSize, fontWeight: fontWeight));
}
