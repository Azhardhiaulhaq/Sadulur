import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/forum_reply.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/forum/forum.action.dart';

CollectionReference threadsCollection =
    FirebaseFirestore.instance.collection('threads');

CollectionReference getLikesCollection(String id) {
  return FirebaseFirestore.instance
      .collection('threads')
      .doc(id)
      .collection('likes');
}

CollectionReference getCommentsCollection(String id) {
  return FirebaseFirestore.instance
      .collection('threads')
      .doc(id)
      .collection('comments');
}

Middleware<AppState> forumMiddleware = (store, action, next) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  if (action is ForumInitAction) {
    threadsCollection.get().then((querySnapshot) async {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      List<ForumPost> listPost = [];

      for (var document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        QuerySnapshot commentSnapshot =
            await getCommentsCollection(document.id).get();
        int comments = commentSnapshot.size;

        ForumPost post = ForumPost(
            postID: document.id,
            title: data['title'] ?? "",
            author: data['author'] ?? "",
            authorID: data['authorID'] ?? "",
            createdTime: data['createdAt'].toDate(),
            content: data['content'] ?? "",
            tags: List<String>.from(data['tags'] ?? []),
            comments: comments,
            likes: data['likes'] ?? 0,
            views: data['views'] ?? 0);

        listPost.add(post);
      }
      store.dispatch(ForumInitSuccessAction(payload: listPost));
    }).catchError((error) {
      store.dispatch(ForumInitFailedAction(error: error.toString()));
    });
  } else if (action is GetForumRepliesAction) {
    getCommentsCollection(action.forumID)
        .orderBy('createdAt', descending: false)
        .get()
        .then((querySnapshot) async {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      List<ForumReply> replies = [];
      for (var document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        ForumReply reply = ForumReply(
            replyID: document.id,
            author: data['author'] ?? "",
            authorID: data['authorID'] ?? "",
            createdTime: data['createdAt'].toDate(),
            content: data['content'] ?? "",
            referenceID: data['reference'],
            threadID: action.forumID,
            likes: data['likes'] ?? 0);
        replies.add(reply);
      }
      store.dispatch(GetForumRepliesSuccessAction(payload: replies));
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(ForumInitFailedAction(error: error.toString()));
    });
  } else if (action is AddForumReply) {
    firestore
        .collection('threads')
        .doc(action.reply.threadID)
        .collection('comments')
        .add({
      'author': action.reply.author,
      'authorID': action.reply.authorID,
      'content': action.reply.content,
      'createdAt': action.reply.createdTime,
      'reference': action.reply.referenceID,
      'likes': 0
    }).then((document) {
      document.get().then((value) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        ForumReply newReply = ForumReply(
            threadID: action.reply.threadID,
            replyID: document.id,
            author: data['author'],
            authorID: data['authorID'],
            content: data['content'],
            likes: data['likes'] ?? 0,
            createdTime: data['createdAt'].toDate(),
            referenceID: data['reference']);
        store.dispatch(AddForumReplySuccess(payload: newReply));
      }).catchError((error) {
        store.dispatch(ForumFailedAction(error: error.toString()));
      });
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(ForumFailedAction(error: error.toString()));
    });
  } else if (action is AddForumPostAction) {
    firestore.collection('threads').add({
      'title': action.post.title,
      'author': action.post.author,
      'authorID': action.post.authorID,
      'createdAt': action.post.createdTime,
      'content': action.post.content,
      'views': action.post.views,
      'tags': action.post.tags
    }).then((document) {
      document.get().then((value) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        ForumPost newPost = ForumPost(
            postID: document.id,
            title: data["title"] ?? "",
            author: data["author"],
            authorID: data["authorID"],
            createdTime: data["createdAt"].toDate(),
            content: data["content"],
            tags: List.from(data["tags"] ?? []));
        store.dispatch(AddForumPostSuccess(payload: newPost));
      });
    }).catchError((error) {
      logger.e(error);
      store.dispatch(ForumFailedAction(error: error.toString()));
    });
  } else if (action is LikePostAction) {
    firestore
        .collection('threads')
        .doc(action.postID)
        .update({"likes": FieldValue.increment(1)}).then((value) {
      firestore.collection('users').doc(action.userID).update({
        'likedPost': FieldValue.arrayUnion([action.postID])
      }).catchError((error) {
        store.dispatch(ForumFailedAction(error: error.toString()));
      });
      store.dispatch(LikePostActionSuccess(payload: action.postID));
    }).catchError((error) {
      store.dispatch(ForumFailedAction(error: error.toString()));
    });
  } else if (action is UnlikePostAction) {
    firestore
        .collection('threads')
        .doc(action.postID)
        .update({"likes": FieldValue.increment(-1)}).then((value) {
      firestore.collection('users').doc(action.userID).update({
        'likedPost': FieldValue.arrayRemove([action.postID])
      }).catchError((error) {
        store.dispatch(ForumFailedAction(error: error.toString()));
      });
      store.dispatch(UnLikePostActionSuccess(payload: action.postID));
    }).catchError((error) {
      store.dispatch(ForumFailedAction(error: error.toString()));
    });
  } else if (action is ViewPostAction) {
    firestore
        .collection('threads')
        .doc(action.postID)
        .update({'views': FieldValue.increment(1)}).then((value) {
      store.dispatch(ViewPostActionSuccess(payload: action));
    }).catchError((error) {
      store.dispatch(ForumFailedAction(error: error.toString()));
    });
  } else if (action is LikePostReplyAction) {
    firestore
        .collection('threads')
        .doc(action.postID)
        .collection('comments')
        .doc(action.replyID)
        .update({"likes": FieldValue.increment(1)}).then((value) {
      firestore.collection('users').doc(action.userID).update({
        'likedPost': FieldValue.arrayUnion([action.postID])
      }).catchError((error) {
        store.dispatch(ForumFailedAction(error: error.toString()));
      });
      store.dispatch(LikePostReplyActionSuccess(payload: action.replyID));
    }).catchError((error) {
      store.dispatch(ForumFailedAction(error: error.toString()));
    });
  } else if (action is UnlikePostReplyAction) {
    logger.d("---------- MASUK UNLIKE REPLY ---------");
    firestore
        .collection('threads')
        .doc(action.postID)
        .collection('comments')
        .doc(action.replyID)
        .update({"likes": FieldValue.increment(-1)}).then((value) {
      firestore.collection('users').doc(action.userID).update({
        'likedPost': FieldValue.arrayRemove([action.postID])
      }).catchError((error) {
        logger.e(error.toString());
        store.dispatch(ForumFailedAction(error: error.toString()));
      });
      store.dispatch(UnlikePostReplyActionSuccess(payload: action.replyID));
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(ForumFailedAction(error: error.toString()));
    });
  }

  next(action);
};
