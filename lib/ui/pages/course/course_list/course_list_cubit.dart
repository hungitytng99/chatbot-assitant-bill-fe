import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/exercise_repository.dart';
part 'course_list_state.dart';

class CourseListCubit extends Cubit<CourseListState> {
  ExerciseRepository exerciseRepository;
  CourseListCubit({
    required this.exerciseRepository,
  }) : super(CourseListState());

  Future<void> getExercises() async {
    emit(state.copyWith(getExercisesStatus: LoadStatus.loading));
    try {
      final List<ExerciseEntity> result =
          await exerciseRepository.getExercises();

      emit(state.copyWith(
        getExercisesStatus: LoadStatus.success,
        exercises: result,
      ));
    } catch (e) {
      emit(state.copyWith(getExercisesStatus: LoadStatus.failure));
    }
  }

  Future<void> getExercisesByHashTag({required List<String> hashTags}) async {
    emit(state.copyWith(getExercisesStatus: LoadStatus.loading));
    try {
      final List<ExerciseEntity> result =
          await exerciseRepository.getExercises();

      emit(state.copyWith(
        getExercisesStatus: LoadStatus.success,
        exercises: result,
      ));
    } catch (e) {
      emit(state.copyWith(getExercisesStatus: LoadStatus.failure));
    }
  }
}
