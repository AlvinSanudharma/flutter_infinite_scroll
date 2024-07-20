part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

@freezed
class PostState with _$PostState {
  const factory PostState({
    @Default(PostStatus.initial) PostStatus status,
    @Default(<Post>[]) List<Post> posts,
    @Default(false) bool hasReachedMax,
  }) = _PostState;
}
