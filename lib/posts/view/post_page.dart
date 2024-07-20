import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_scroll/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_scroll/posts/view/post_list.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  PostBloc(dio: Dio())..add(const PostEvent.postFetched()))
        ],
        child: const PostList(),
      ),
    );
  }
}
