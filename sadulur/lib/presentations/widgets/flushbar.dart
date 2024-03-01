import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushbar {
  static void showFlushbar(
      BuildContext context, String title, String message, Color color) {
    Flushbar(
      title: title,
      message: message,
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
    ).show(context);
  }
}
