import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/forum_reply.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/forum/forum.action.dart';

class ForumPostReplyCard extends StatefulWidget {
  final ForumReply reply;
  final UMKMUser user;
  final VoidCallback onReplyIconClicked;
  final ForumReply? reference;
  const ForumPostReplyCard(
      {super.key,
      required this.reply,
      required this.user,
      this.reference,
      required this.onReplyIconClicked});

  @override
  _ForumPostReplyCardState createState() => _ForumPostReplyCardState();
}

class _ForumPostReplyCardState extends State<ForumPostReplyCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 100.0, // Set the minimum height as needed
      ),
      child: Card(
        elevation: 8.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: widget.reply.authorID == widget.user.id
                ? AppColor.secondaryTextDatalab
                : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 2.0,
              ),
              widget.reference != null
                  ? Card(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(widget.reference?.author ?? "",
                                  style: CustomTextStyles.normalText(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(widget.reference?.content ?? "",
                                  maxLines: 2,
                                  style: CustomTextStyles.normalText(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  )),
                            ]),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 4,
              ),
              Text(widget.reply.author,
                  style: CustomTextStyles.normalText(
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )),
              const SizedBox(
                height: 2.0,
              ),
              Text(formatDateTime(widget.reply.createdTime),
                  style: CustomTextStyles.normalText(
                    color: AppColor.darkGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  )),
              const SizedBox(
                height: 8.0,
              ),
              Text(widget.reply.content,
                  style: CustomTextStyles.normalText(
                    color: AppColor.black,
                    fontSize: 14,
                  )),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                // Add a Divider
                height: 1, // Set the height of the divider
                color: AppColor.lightGrey, // Set the color of the divider
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _thumbIcon(context),
                  GestureDetector(
                    onTap: widget.onReplyIconClicked,
                    child: Row(
                      children: [
                        const Icon(Icons.reply_outlined,
                            color: AppColor.darkGrey, size: 18),
                        const SizedBox(width: 4.0),
                        Text(
                          "Reply",
                          style: CustomTextStyles.iconText1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumbIcon(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () async {
          if (widget.user.likedPost.contains(widget.reply.replyID)) {
            store.dispatch(UnlikePostReplyAction(
                postID: widget.reply.threadID!,
                userID: widget.user.id,
                replyID: widget.reply.replyID));
            setState(() {});
          } else {
            store.dispatch(LikePostReplyAction(
                postID: widget.reply.threadID!,
                userID: widget.user.id,
                replyID: widget.reply.replyID));
            setState(() {});
          }
        };
      },
      builder: (BuildContext context, VoidCallback callback) {
        logger.d("--- ${widget.user.likedPost} vs ${widget.reply.replyID}");
        return GestureDetector(
            onTap: callback,
            child: Row(
              children: [
                Icon(Icons.thumb_up,
                    color: widget.user.likedPost.contains(widget.reply.replyID)
                        ? AppColor.likedIcon
                        : AppColor.darkGrey,
                    size: 18),
                const SizedBox(width: 4.0),
                Text("${widget.reply.likes} Likes",
                    style: CustomTextStyles.iconText1)
              ],
            ));
      },
    );
  }
}

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else {
    final formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(dateTime);
  }
}
