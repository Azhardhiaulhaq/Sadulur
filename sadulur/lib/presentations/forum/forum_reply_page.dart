import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/forum_reply.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/forum/widget/forum_post_reply_card.dart';
import 'package:sadulur/presentations/forum/widget/post_reply_thread_card.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/forum/forum.action.dart';
import 'package:google_fonts/google_fonts.dart';

class ForumReplyPage extends StatelessWidget {
  const ForumReplyPage({super.key, required this.title, required this.postID});

  final String title;
  final String postID;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ForumPageViewModel>(
      converter: (Store<AppState> store) => _ForumPageViewModel(
          posts: store.state.forumState.posts.firstWhere(
              (post) => post.postID == postID,
              orElse: () => ForumPost.empty()),
          isLoading: store.state.forumState.loading,
          error: store.state.forumState.error,
          user: store.state.loginState.user,
          replies: store.state.forumState.replies ?? []),
      onInit: (store) => store.dispatch(GetForumRepliesAction(forumID: postID)),
      onWillChange: (previousViewModel, newViewModel) {},
      builder: (BuildContext context, _ForumPageViewModel viewModel) {
        return _ForumPageContent(
          title: title,
          isLoading: viewModel.isLoading,
          posts: viewModel.posts,
          user: viewModel.user,
          replies: viewModel.replies,
        );
      },
    );
  }
}

class _ForumPageViewModel {
  final ForumPost posts;
  final bool isLoading;
  final UMKMUser user;
  final List<ForumReply> replies;
  final String error;

  _ForumPageViewModel(
      {required this.posts,
      required this.isLoading,
      required this.user,
      required this.error,
      required this.replies});
}

class _ForumPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final ForumPost posts;
  final UMKMUser user;
  final List<ForumReply> replies;

  const _ForumPageContent(
      {required this.title,
      required this.isLoading,
      required this.posts,
      required this.user,
      required this.replies});

  @override
  _ForumPageContentState createState() => _ForumPageContentState();
}

class _ForumPageContentState extends State<_ForumPageContent> {
  final TextEditingController _textFieldController = TextEditingController();
  ForumReply? repliedTo;

  @override
  void didUpdateWidget(covariant _ForumPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 80.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.darkDatalab),
            onPressed: () {
              // Handle the back button functionality here
              Navigator.of(context).pop();
            },
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.posts.title,
                style: CustomTextStyles.appBarTitle1,
              ),
              Text(
                "By ${widget.posts.author}",
                style: CustomTextStyles.appBarTitle2,
              ),
            ],
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[200],
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 72),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ForumPostReplyThreadCard(
                        post: widget.posts,
                        isAuthor: widget.posts.authorID == widget.user.id,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Replies (${widget.posts.comments})",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: AppColor.darkDatalab,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        physics:
                            const NeverScrollableScrollPhysics(), // Added to disable internal scrolling
                        shrinkWrap: true,
                        itemCount: widget.replies.length,
                        itemBuilder: (context, index) {
                          ForumReply? reference;
                          if (widget.replies[index].referenceID != null) {
                            reference = widget.replies.firstWhere(
                              (reply) =>
                                  reply.replyID ==
                                  widget.replies[index].referenceID,
                            );
                          }

                          return ForumPostReplyCard(
                            reply: widget.replies[index],
                            user: widget.user,
                            reference: reference,
                            onReplyIconClicked: () {
                              setState(() {
                                repliedTo = widget.replies[index];
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            )),
        // Add a stack to overlay the send button and text field
        floatingActionButton: _addReplyForm(context));
  }

  Widget _addReplyForm(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () async {
          // Handle sending the reply here
          String replyText = _textFieldController.text;
          ForumReply newReply = ForumReply(
              threadID: widget.posts.postID,
              authorID: widget.user.id,
              author: widget.user.userName,
              createdTime: DateTime.now(),
              likes: 0,
              content: replyText,
              replyID: '',
              referenceID: repliedTo?.replyID);
          // Clear the text field after sending
          store.dispatch(AddForumReply(reply: newReply));
          _textFieldController.clear();
          setState(() {});
        };
      },
      builder: (BuildContext context, VoidCallback callback) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 4, 2, 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text field
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      repliedTo != null
                          ? Stack(
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    side: const BorderSide(
                                      color: AppColor.darkDatalab,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Container(
                                    color: AppColor.lightGrey,
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          repliedTo?.author ?? "",
                                          style: CustomTextStyles.normalText(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          repliedTo?.content ?? "",
                                          maxLines: 1,
                                          style: CustomTextStyles.normalText(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            repliedTo = null;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.clear,
                                          color: AppColor.redEmail,
                                        ),
                                      ),
                                    )),
                                widget.isLoading
                                    ? const Center(
                                        child: CircularProgressCard(),
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),
                      TextField(
                        controller: _textFieldController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.backgroundWhite,
                          hintText: 'Type your reply...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    ],
                  )),
                  // Send button
                  const SizedBox(
                      width: 8.0), // Add spacing between text field and button
                  FloatingActionButton(
                    backgroundColor: AppColor.darkDatalab,
                    onPressed: callback,
                    child: const Icon(
                      Icons.send,
                      color: AppColor.secondaryTextDatalab,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
