import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:googleapis/containeranalysis/v1.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user_assessment.dart';

class UMKMUser {
  final String email;
  final String id;
  final String userName;
  final bool isAdmin;
  final String? name;
  final int? age;
  final String? education;
  List<String> likedPost;
  UserAssessment assessment;
  DateTime updatedAt;
  DateTime createdAt;
  UMKMStore store;

  UMKMUser(
      {required this.email,
      required this.id,
      required this.userName,
      required this.updatedAt,
      required this.createdAt,
      required this.store,
      this.name,
      this.age,
      this.education,
      this.likedPost = const [],
      this.isAdmin = false,
      required this.assessment});

  void addLikedPost(String id) {
    likedPost.add(id);
  }

  void updateUser(DateTime date) {
    updatedAt = date;
  }

  UMKMUser copyWith({
    String? email,
    String? id,
    String? userName,
    DateTime? updatedAt,
    DateTime? createdAt,
    UMKMStore? store,
    String? name,
    int? age,
    String? education,
    List<String>? likedPost,
    bool? isAdmin,
    UserAssessment? assessment,
  }) {
    return UMKMUser(
      email: email ?? this.email,
      id: id ?? this.id,
      userName: userName ?? this.userName,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      store: store ?? this.store,
      name: name ?? this.name,
      age: age ?? this.age,
      education: education ?? this.education,
      likedPost: likedPost ?? this.likedPost,
      isAdmin: isAdmin ?? this.isAdmin,
      assessment: assessment ?? this.assessment,
    );
  }

  factory UMKMUser.fromMap(Map<String, dynamic> data, String id,
      UserAssessment assessment, UMKMStore store) {
    return UMKMUser(
        email: data['email'] ?? "",
        id: id,
        userName: data['username'] ?? "",
        name: data['name'],
        age: data['age'],
        education: data['educaton'],
        updatedAt: data['updatedAt'].toDate() ?? DateTime.now(),
        likedPost: List.from(data['likedPost'] ?? []),
        assessment: assessment,
        isAdmin: data['isAdmin'] ?? false,
        createdAt: data['createdAt'] ?? DateTime.now(),
        store: store);
  }

  factory UMKMUser.empty() {
    return UMKMUser(
        email: 'azhar@tantowi.com',
        id: 'G5zBIgQ0N7ZGp0w0lCF7AwsbdE73',
        userName: 'azhard229',
        likedPost: [],
        isAdmin: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        store: UMKMStore.empty(),
        assessment: UserAssessment.empty());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UMKMUser &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          id == other.id &&
          userName == other.userName &&
          isAdmin == other.isAdmin &&
          name == other.name &&
          age == other.age &&
          education == other.education &&
          listEquals(likedPost, other.likedPost) &&
          assessment == other.assessment &&
          createdAt == other.createdAt &&
          store == other.store &&
          updatedAt == other.updatedAt;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
