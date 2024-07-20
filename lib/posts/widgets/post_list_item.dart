import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll/posts/models/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      child: ListTile(
        leading: Text('${post.id}', style: textTheme.bodySmall),
        title: Text(post.title ?? 'default_title'),
        isThreeLine: true,
        subtitle: Text(post.body ?? 'default_body'),
        dense: true,
      ),
    );
  }
}
