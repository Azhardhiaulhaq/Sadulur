import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/forum/forum_reply_page.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/forum/forum.action.dart';

class ForumPostCard extends StatefulWidget {
  final UMKMUser user;
  final ForumPost post;

  const ForumPostCard({super.key, required this.post, required this.user});
  @override
  _ForumPostCardState createState() => _ForumPostCardState();
}

class _ForumPostCardState extends State<ForumPostCard> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
        converter: (Store<AppState> store) {
      return () async {
        store.dispatch(ViewPostAction(postID: widget.post.postID));
        PersistentNavBarNavigator.pushNewScreen(context,
            screen: ForumReplyPage(
              title: widget.post.title,
              postID: widget.post.postID,
            ),
            withNavBar: false);
      };
    }, builder: (BuildContext context, VoidCallback callback) {
      return ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 100.0, // Set the minimum height as needed
          ),
          child: InkWell(
            onTap: callback,
            child: Card(
              elevation: 8.0,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.post.title,
                      maxLines: 2,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: AppColor.darkDatalab,
                          fontWeight:
                              FontWeight.bold, // You can adjust the font weight
                          fontSize: 16.0, // Adjust the font size if needed
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        // Add your avatar image or initials here
                        child: Text(widget.post.author
                            .substring(0, 2)
                            .toUpperCase()), // Example: Display initials
                      ),
                      title: Text(
                        widget.post.author,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: AppColor.darkDatalab,
                            fontWeight: FontWeight
                                .w700, // You can adjust the font weight
                            fontSize: 14.0, // Adjust the font size if needed
                          ),
                        ),
                      ),
                      subtitle: Text(formatDateTime(widget.post.createdTime),
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: AppColor.darkGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0))),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(widget.post.content,
                        maxLines: 3,
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: AppColor.darkDatalab,
                                fontSize: 12,
                                fontWeight: FontWeight.normal))),
                    const SizedBox(
                      height: 16.0,
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
                        _thumbIcon(context, widget.post.postID),
                        Row(
                          children: [
                            const Icon(Icons.comment,
                                color: AppColor.darkGrey, size: 18),
                            const SizedBox(width: 4.0),
                            Text(
                              "${widget.post.comments ?? 0} Replies",
                              style: CustomTextStyles.iconText1,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.remove_red_eye_outlined,
                                color: AppColor.darkGrey, size: 18),
                            const SizedBox(width: 4.0),
                            Text(
                              "${widget.post.views ?? 0} Views",
                              style: CustomTextStyles.iconText1,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }

  Widget _thumbIcon(BuildContext context, String postID) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () async {
          if (widget.user.likedPost.contains(postID)) {
            // store.dispatch(UnlikePostAction(postID));
            store.dispatch(
                UnlikePostAction(postID: postID, userID: widget.user.id));
            setState(() {});
          } else {
            logger.d("Ada");
            store.dispatch(
                LikePostAction(postID: postID, userID: widget.user.id));
            setState(() {});
          }
        };
      },
      builder: (BuildContext context, VoidCallback callback) {
        return GestureDetector(
            onTap: callback,
            child: Row(
              children: [
                Icon(Icons.thumb_up,
                    color: widget.user.likedPost.contains(widget.post.postID)
                        ? AppColor.likedIcon
                        : AppColor.darkGrey,
                    size: 18),
                const SizedBox(width: 4.0),
                Text("${widget.post.likes} Likes",
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
    if (difference.inHours == 0) {
      return 'Just Now';
    } else {
      return '${difference.inHours} hours ago';
    }
  } else {
    final formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(dateTime);
  }
}
