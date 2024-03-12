import 'package:flutter/material.dart';

class AppState {
  final bool isLoading;

  AppState({
    required this.isLoading,
  });

  factory AppState.initial() => AppState(
        isLoading: false,
      );

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is AppState && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return "AppState { loginState: }";
  }
}
