import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  final String tag;

  TagCard({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          tag,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
