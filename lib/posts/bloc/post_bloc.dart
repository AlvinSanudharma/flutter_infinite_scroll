import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_infinite_scroll/posts/models/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

const throttleDuration = Duration(milliseconds: 100);

const _postLimit = 20;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.dio}) : super(const PostState()) {
    on<PostEvent>(_onPostFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  final Dio dio;

  Future<void> _onPostFetched(PostEvent event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();

        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      final posts = await _fetchPosts(state.posts.length);

      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts',
        queryParameters: {'_start': '$startIndex', '_limit': _postLimit});

    if (response.statusCode == 200) {
      final List<dynamic> body = response.data;

      return body.map(
        (e) {
          final map = Post.fromJson(e);

          return Post(
            userId: map.userId,
            id: map.id,
            title: map.title,
            body: map.body,
          );
        },
      ).toList();
    }

    throw Exception('error fetching posts');
  }
}
