import 'package:flutter/foundation.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/forum_reply.dart';

class ForumState {
  final bool loading;
  final String error;
  final List<ForumPost> posts;
  final List<ForumReply>? replies;

  ForumState(
      {required this.loading,
      required this.error,
      required this.posts,
      this.replies});

  factory ForumState.initial() {
    return ForumState(loading: false, error: '', posts: [], replies: null);
  }

  ForumState copyWith({
    bool? loading,
    String? error,
    List<ForumPost>? posts,
    List<ForumReply>? replies,
  }) {
    return ForumState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      posts: posts ?? this.posts,
      replies: replies ?? this.replies,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForumState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          error == other.error &&
          listEquals(posts, other.posts);

  @override
  int get hashCode =>
      runtimeType.hashCode ^ loading.hashCode ^ error.hashCode ^ posts.hashCode;

  @override
  String toString() =>
      "ForumState { loading: $loading, error: $error, posts: $posts }";
}
