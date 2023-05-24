part of 'course_list_cubit.dart';

class CourseListState extends Equatable {
  final LoadStatus getHashtagStatus;
  List<String> hashtags;

  @override
  List<Object?> get props => [
        getHashtagStatus,
        hashtags,
      ];

  CourseListState({
    this.getHashtagStatus = LoadStatus.initial,
    this.hashtags = const [],
  });

  CourseListState copyWith({
    LoadStatus? getHashtagStatus,
    List<String>? hashtags,
  }) {
    return CourseListState(
      getHashtagStatus: getHashtagStatus ?? this.getHashtagStatus,
      hashtags: hashtags ?? this.hashtags,
    );
  }
}
