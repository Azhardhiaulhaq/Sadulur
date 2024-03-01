import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/presentations/widgets/forum/forum_tag_card.dart';

class ForumPostReplyThreadCard extends StatelessWidget {
  final bool isAuthor;
  final ForumPost post;
  const ForumPostReplyThreadCard(
      {super.key, this.isAuthor = false, required this.post});

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
            color:
                isAuthor ? AppColor.secondaryTextDatalab : Colors.transparent,
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
              Text(post.content,
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: AppColor.darkDatalab,
                          fontSize: 14,
                          fontWeight: FontWeight.normal))),
              const SizedBox(
                height: 16.0,
              ),
              Wrap(
                spacing: 4.0, // Adjust the spacing between tags as needed
                runSpacing: 2.0, // Adjust the run spacing as needed
                children: post.tags
                    .map((tag) => ForumTagCard(tag: tag ?? ""))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
