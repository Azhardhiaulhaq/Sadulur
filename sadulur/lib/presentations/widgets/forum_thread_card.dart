import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/presentations/widgets/forum_tag_card.dart';

class ThreadCard extends StatelessWidget {
  final String title;
  final String author;
  final DateTime createdTime;
  final String content;
  final List<String> tags;

  ThreadCard({
    required this.title,
    required this.author,
    required this.createdTime,
    required this.content,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      color: AppColor.backgroundWhite,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$author - ${_formatDate(createdTime)}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const Divider(height: 20, color: Colors.grey),
            Text(
              content.substring(0, 100),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            if (tags.isNotEmpty) ...[
              const Text(
                'Tags:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: tags
                    .map(
                      (tag) => TagCard(tag: tag),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    // Implement your own date formatting logic
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}
