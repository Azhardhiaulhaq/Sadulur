class ForumReply {
  final String? threadID;
  final String replyID;
  final String? referenceID;
  final String author;
  final String authorID;
  final DateTime createdTime;
  final String content;
  int likes;

  ForumReply(
      {required this.replyID,
      required this.author,
      required this.authorID,
      required this.createdTime,
      required this.content,
      required this.likes,
      this.threadID,
      this.referenceID});

  // Empty initiator
  factory ForumReply.empty() {
    return ForumReply(
      replyID: '',
      author: '',
      authorID: '',
      createdTime: DateTime.now(),
      content: '',
      likes: 0,
    );
  }

  void incrementLikes(int value) {
    likes = likes + value;
  }

  ForumReply copyWith({
    String? threadID,
    String? replyID,
    String? referenceID,
    String? author,
    String? authorID,
    DateTime? createdTime,
    String? content,
    int? likes,
  }) {
    return ForumReply(
      threadID: threadID ?? this.threadID,
      replyID: replyID ?? this.replyID,
      referenceID: referenceID ?? this.referenceID,
      author: author ?? this.author,
      authorID: authorID ?? this.authorID,
      createdTime: createdTime ?? this.createdTime,
      content: content ?? this.content,
      likes: likes ?? this.likes,
    );
  }

  // Check if instance is empty
  bool get isEmpty {
    return replyID.isEmpty &&
        author.isEmpty &&
        authorID.isEmpty &&
        createdTime == DateTime(0) &&
        content.isEmpty &&
        likes == 0 &&
        referenceID == null;
  }
}
