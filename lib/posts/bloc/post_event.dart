part of 'post_bloc.dart';

@freezed
class PostEvent with _$PostEvent {
  const factory PostEvent.started() = _Started;
  const factory PostEvent.postFetched() = _PostFetched;
}
