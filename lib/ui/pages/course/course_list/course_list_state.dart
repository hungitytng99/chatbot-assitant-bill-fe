part of 'course_list_cubit.dart';

class CourseListState extends Equatable {
  final LoadStatus getExercisesStatus;
  List<ExerciseEntity> exercises;

  @override
  List<Object?> get props => [
        getExercisesStatus,
        exercises,
      ];

  CourseListState({
    this.getExercisesStatus = LoadStatus.initial,
    this.exercises = const [],
  });

  CourseListState copyWith({
    LoadStatus? getExercisesStatus,
    List<ExerciseEntity>? exercises,
  }) {
    return CourseListState(
      getExercisesStatus: getExercisesStatus ?? this.getExercisesStatus,
      exercises: exercises ?? this.exercises,
    );
  }
}
