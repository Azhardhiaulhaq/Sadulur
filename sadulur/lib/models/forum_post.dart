class ForumPost {
  final String postID;
  final String title;
  final String author;
  final String authorID;
  final DateTime createdTime;
  final String content;
  final List<String> tags;
  int? likes;
  int? views;
  final int? comments;
  final List<String>? images;

  ForumPost(
      {required this.postID,
      required this.title,
      required this.author,
      required this.authorID,
      required this.createdTime,
      required this.content,
      required this.tags,
      this.likes,
      this.views,
      this.comments,
      this.images});

  ForumPost copyWith({
    String? postID,
    String? title,
    String? author,
    String? authorID,
    DateTime? createdTime,
    String? content,
    List<String>? tags,
    int? likes,
    int? views,
    int? comments,
    List<String>? images,
  }) {
    return ForumPost(
      postID: postID ?? this.postID,
      title: title ?? this.title,
      author: author ?? this.author,
      authorID: authorID ?? this.authorID,
      createdTime: createdTime ?? this.createdTime,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      comments: comments ?? this.comments,
      images: images ?? this.images,
    );
  }

  static ForumPost empty() {
    return ForumPost(
      postID: '',
      title: '',
      author: '',
      authorID: '',
      createdTime: DateTime(0),
      content: '',
      tags: [],
      likes: null,
      views: null,
      comments: null,
    );
  }

  void incrementLikes(int value) {
    likes = (likes! + value);
  }

  void incrementViews(int value) {
    views = (views! + value);
  }

  bool isEmpty() {
    return postID.isEmpty &&
        title.isEmpty &&
        author.isEmpty &&
        authorID.isEmpty &&
        createdTime == DateTime(0) &&
        content.isEmpty &&
        tags.isEmpty &&
        likes == null &&
        views == null &&
        comments == null;
  }
}
