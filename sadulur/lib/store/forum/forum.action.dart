import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/forum_reply.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';

class ForumAction {
  @override
  String toString() {
    return 'ForumAction { }';
  }
}

class ForumInitAction {
  final String type = "FORUM_INIT";
  ForumInitAction();

  @override
  String toString() {
    return 'ForumInitAction { }';
  }
}

class ForumInitSuccessAction {
  final type = "FORUM_INIT_SUCCESS";
  final dynamic payload;

  ForumInitSuccessAction({required this.payload});
  @override
  String toString() {
    return 'ForumInitSuccessAction { isSuccess: $payload }';
  }
}

class ForumInitFailedAction {
  final type = "FORUM_INIT_FAILED";
  final String error;

  ForumInitFailedAction({required this.error});

  @override
  String toString() {
    return 'ForumFailedAction { error: $error }';
  }
}

class ForumSuccessAction {
  final int isSuccess;

  ForumSuccessAction({required this.isSuccess});
  @override
  String toString() {
    return 'ForumSuccessAction { isSuccess: $isSuccess }';
  }
}

class ForumFailedAction {
  final String error;

  ForumFailedAction({required this.error});
  final String type = "FORUM_ACTION_FAILED";
  @override
  String toString() {
    return 'ForumFailedAction { error: $error }';
  }
}

class GetForumRepliesAction {
  final String type = "GET_FORUM_REPLIES";
  final String forumID;

  GetForumRepliesAction({required this.forumID});
}

class GetForumRepliesSuccessAction {
  final String type = "GET_FORUM_REPLIES_SUCCESS";
  final dynamic payload;

  GetForumRepliesSuccessAction({required this.payload});
}

class AddForumReply {
  final String type = "ADD_FORUM_REPLY";
  final ForumReply reply;

  AddForumReply({required this.reply});
}

class AddForumReplySuccess {
  final String type = "ADD_FORUM_REPLY_SUCCESS";
  final dynamic payload;
  AddForumReplySuccess({required this.payload});
}

class AddForumPostAction {
  final String type = "ADD_FORUM_POST";
  final ForumPost post;
  final UMKMUser author;

  AddForumPostAction({required this.post, required this.author});
}

class AddForumPostSuccess {
  final String type = "ADD_FORUM_POST_SUCCESS";
  final dynamic payload;
  AddForumPostSuccess({required this.payload});
}

class LikePostAction {
  final String type = "LIKE_POST_ACTION";
  final String postID;
  final String userID;
  LikePostAction({required this.postID, required this.userID});
}

class LikePostActionSuccess {
  final String type = "LIKE_POST_ACTION_SUCCESS";
  final dynamic payload;
  LikePostActionSuccess({required this.payload});
}

class UnlikePostAction {
  final String type = "UNLIKE_POST_ACTION";
  final String postID;
  final String userID;
  UnlikePostAction({required this.postID, required this.userID});
}

class UnLikePostActionSuccess {
  final String type = "LIKE_POST_ACTION_SUCCESS";
  final dynamic payload;
  UnLikePostActionSuccess({required this.payload});
}

class ViewPostAction {
  final String type = "VIEW_POST_ACTION";
  final String postID;
  ViewPostAction({required this.postID});
}

class ViewPostActionSuccess {
  final String type = "VIEW_POST_ACTION_SUCCESS";
  final dynamic payload;
  ViewPostActionSuccess({required this.payload});
}

class LikePostReplyAction {
  final String type = "LIKE_POST_REPLY_ACTION";
  final String postID;
  final String replyID;
  final String userID;
  LikePostReplyAction(
      {required this.postID, required this.userID, required this.replyID});
}

class LikePostReplyActionSuccess {
  final String type = "LIKE_POST_REPLY_ACTION_SUCCESS";
  final dynamic payload;
  LikePostReplyActionSuccess({required this.payload});
}

class UnlikePostReplyAction {
  final String type = "UNLIKE_POST_REPLY_ACTION";
  final String postID;
  final String userID;
  final String replyID;
  UnlikePostReplyAction(
      {required this.postID, required this.userID, required this.replyID});
}

class UnlikePostReplyActionSuccess {
  final String type = "UNLIKE_POST_REPLY_ACTION_SUCCESS";
  final dynamic payload;
  UnlikePostReplyActionSuccess({required this.payload});
}
