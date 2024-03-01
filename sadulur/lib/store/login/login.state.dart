import 'package:sadulur/models/user.dart';

class LoginState {
  final bool loading;
  final String error;
  final bool isLoggedIn;
  final UMKMUser user;

  LoginState(this.loading, this.error, this.isLoggedIn, this.user);

  factory LoginState.initial() =>
      LoginState(false, '', false, UMKMUser.empty());

  LoginState copyWith(
          {bool? loading, String? error, bool? isLoggedIn, UMKMUser? user}) =>
      LoginState(loading ?? this.loading, error ?? this.error,
          isLoggedIn ?? this.isLoggedIn, user ?? this.user);

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          error == other.error &&
          isLoggedIn == other.isLoggedIn &&
          user == other.user;

  @override
  int get hashCode =>
      super.hashCode ^ runtimeType.hashCode ^ loading.hashCode ^ error.hashCode;

  @override
  String toString() =>
      "LoginState { loading: $loading,  error: $error, isLoggedIn: $isLoggedIn}";
}
