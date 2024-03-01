import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';

class FileRow extends StatelessWidget {
  final IconData icon;
  final String fileName;
  final VoidCallback onTap;

  const FileRow({
    required this.icon,
    required this.fileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: AppColor.darkDatalab,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              fileName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.close,
              size: 16,
              color: AppColor.deadlineRed,
            ),
          ),
        ],
      ),
    );
  }
}
