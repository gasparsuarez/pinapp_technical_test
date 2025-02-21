import 'package:flutter/material.dart';
import 'package:pinapp_test/app/domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
  });

  final PostEntity post;

  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.all(size.width * .02),
      child: Container(
        padding: EdgeInsets.all(size.width * .02),
        child: Row(
          children: [
            Flexible(
              flex: 6,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * .04,
                      ),
                    ),
                    Divider(),
                    Text(post.body),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => onTap(post.id),
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
