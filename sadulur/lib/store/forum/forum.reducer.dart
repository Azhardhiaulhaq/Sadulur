import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/forum_reply.dart';
import 'package:sadulur/store/forum/forum.action.dart';
import './forum.state.dart';

final forumReducer = combineReducers<ForumState>(
    [forumInitReducer, forumInitSuccessReducer, forumInitFailureReducer]);

ForumState forumInitReducer(ForumState state, dynamic action) {
  ForumState newState = state;

  if (action is ForumInitAction) {
    newState = state.copyWith(loading: true, error: "", posts: []);
  } else if (action is GetForumRepliesAction) {
    newState = state.copyWith(loading: true, error: "");
  } else if (action is AddForumReply) {
    newState = state.copyWith(loading: true, error: "");
  } else if (action is AddForumPostAction) {
    newState = state.copyWith(loading: true, error: "");
  } else if (action is LikePostAction) {
    newState = state.copyWith(loading: true, error: "");
  } else if (action is UnlikePostAction) {
    newState = state.copyWith(loading: true, error: "");
  }

  return newState;
}

ForumState forumInitSuccessReducer(ForumState state, dynamic action) {
  ForumState newState = state;
  if (action is ForumInitSuccessAction) {
    newState = state.copyWith(loading: false, error: "", posts: action.payload);
  } else if (action is GetForumRepliesSuccessAction) {
    newState =
        state.copyWith(loading: false, error: "", replies: action.payload);
  } else if (action is AddForumPostSuccess) {
    newState = state.copyWith(
      loading: false,
      error: "",
      posts: [...state.posts, action.payload],
    );
  } else if (action is AddForumReplySuccess) {
    List<ForumPost> listPost = state.posts;
    var index = listPost
        .indexWhere((element) => element.postID == action.payload.threadID);
    logger.d(index);
    if (index != -1) {
      logger.d("----------");
      logger.d(listPost[index].comments);
      listPost[index] = listPost[index]
          .copyWith(comments: (listPost[index].comments ?? 0) + 1);
      logger.d(listPost[index].comments);
    }

    newState = state.copyWith(
        loading: false,
        error: "",
        replies: [...?state.replies, action.payload],
        posts: listPost);
  } else if (action is LikePostActionSuccess) {
    List<ForumPost> listPost = List.from(state.posts);
    var index =
        listPost.indexWhere((element) => element.postID == action.payload);

    if (index != -1) {
      listPost[index] =
          listPost[index].copyWith(likes: (listPost[index].likes ?? 0) + 1);
    }

    newState = state.copyWith(
      posts: listPost,
      loading: false,
      error: "",
    );
  } else if (action is UnLikePostActionSuccess) {
    List<ForumPost> listPost = List.from(state.posts);
    var index =
        listPost.indexWhere((element) => element.postID == action.payload);
    int postLikes = listPost[index].likes ?? 0;

    if (index != -1 && postLikes > 0) {
      listPost[index] = listPost[index].copyWith(likes: postLikes - 1);
    }

    newState = state.copyWith(
      posts: listPost,
      loading: false,
      error: "",
    );
  } else if (action is ViewPostActionSuccess) {
    List<ForumPost> listPost = List.from(state.posts);
    var index =
        listPost.indexWhere((element) => element.postID == action.payload);

    if (index != -1) {
      listPost[index] =
          listPost[index].copyWith(views: (listPost[index].views ?? 0) + 1);
    }

    newState = state.copyWith(
      posts: listPost,
      loading: false,
      error: "",
    );
  } else if (action is LikePostReplyActionSuccess) {
    List<ForumReply> listPost = List.from(state.replies ?? []);
    var index =
        listPost.indexWhere((element) => element.replyID == action.payload);

    if (index != -1) {
      listPost[index] =
          listPost[index].copyWith(likes: (listPost[index].likes ?? 0) + 1);
    }

    newState = state.copyWith(
      replies: listPost,
      loading: false,
      error: "",
    );
  } else if (action is UnlikePostReplyActionSuccess) {
    List<ForumReply> listPost = List.from(state.replies ?? []);
    var index =
        listPost.indexWhere((element) => element.replyID == action.payload);

    if (index != -1) {
      int postLikes = listPost[index].likes ?? 0;
      if (postLikes > 0) {
        listPost[index] = listPost[index].copyWith(likes: postLikes - 1);
      }
    }

    newState = state.copyWith(
      replies: listPost,
      loading: false,
      error: "",
    );
  }

  return newState;
}

ForumState forumInitFailureReducer(ForumState state, dynamic action) {
  ForumState newState = state;

  if (action is ForumFailedAction) {
    newState = state.copyWith(loading: false, error: action.error);
  }

  return newState;
}
