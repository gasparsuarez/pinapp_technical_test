import 'package:flutter/material.dart';
import 'package:pinapp_test/app/domain/entities/comment_entity.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comment,
  });

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.name,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              comment.email,
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        subtitle: Text(
          comment.body,
          style: TextStyle(
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
