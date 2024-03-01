import 'package:flutter/material.dart';
import 'package:sadulur/models/user.dart';

class LoginAction {
  final type = "LOGIN_REQUEST";
  final String email;
  final String password;
  final BuildContext context;

  LoginAction(
      {required this.email, required this.password, required this.context});

  @override
  String toString() {
    return 'LoginAction { }';
  }
}

class GetUserDetailAction {
  final type = "GET_USER_DETAIL_ACTION";
  final String userID;
  GetUserDetailAction({required this.userID});
}

class GetUserDetailSuccessAction {
  final type = "GET_USER_DETAIL_SUCCESS";
  final UMKMUser user;
  GetUserDetailSuccessAction({required this.user});
}

class GetUserDetailFailedAction {
  final type = "GET_USER_DETAIL_FAILED";
  final String error;
  GetUserDetailFailedAction({required this.error});
}

class RegistrationAction {
  final type = "REGISTRATION_REQUEST";
  final String email;
  final String password;
  final String userName;
  final BuildContext context;

  RegistrationAction(
      {required this.email,
      required this.password,
      required this.context,
      required this.userName});

  @override
  String toString() {
    return 'RegistrationAction { }';
  }
}

class LoginSuccessAction {
  final type = "LOGIN_SUCCESS";
  final dynamic payload;

  LoginSuccessAction({required this.payload});
  @override
  String toString() {
    return 'LoginSuccessAction { isSuccess: $payload }';
  }
}

class RegistrationSuccessAction {
  final type = "REGISTRATION_SUCCESS";
  final dynamic payload;

  RegistrationSuccessAction({required this.payload});
  @override
  String toString() {
    return 'RegistrationSuccessAction { isSuccess: $payload }';
  }
}

class LoginFailedAction {
  final type = "LOGIN_FAILED";
  final String error;

  LoginFailedAction({required this.error});

  @override
  String toString() {
    return 'LoginFailedAction { error: $error }';
  }
}

class RegistrationFailedAction {
  final type = "REGISTRATION_FAILED";
  final String error;

  RegistrationFailedAction({required this.error});

  @override
  String toString() {
    return 'RegistrationFailedAction { error: $error }';
  }
}

class UserLikeAction {
  final type = "USER_LIKE_ACTION";
  final String postID;
  UserLikeAction({required this.postID});
}
