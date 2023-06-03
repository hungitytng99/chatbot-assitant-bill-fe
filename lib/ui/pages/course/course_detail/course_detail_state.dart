part of 'course_detail_cubit.dart';

class CourseDetailState extends Equatable {
  final LoadStatus endPracticeStatus;
  final EndPracticeResponseEntity? endPracticeResponse;

  @override
  List<Object?> get props => [
        endPracticeStatus,
        endPracticeResponse,
      ];

  const CourseDetailState({
    this.endPracticeStatus = LoadStatus.initial,
    this.endPracticeResponse,
  });

  CourseDetailState copyWith({
    LoadStatus? endPracticeStatus,
    EndPracticeResponseEntity? endPracticeResponse,
  }) {
    return CourseDetailState(
      endPracticeStatus: endPracticeStatus ?? this.endPracticeStatus,
      endPracticeResponse: endPracticeResponse ?? this.endPracticeResponse,
    );
  }
}
