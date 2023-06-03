import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/params/end_exercise_body.dart';
import 'package:ihz_bql/repositories/exercise_repository.dart';
part 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  ExerciseRepository exerciseRepository;
  CourseDetailCubit({
    required this.exerciseRepository,
  }) : super(CourseDetailState());

  Future<void> endPractices(EndExerciseBody endExerciseBody) async {
    emit(state.copyWith(endPracticeStatus: LoadStatus.loading));
    try {
      final EndPracticeResponseEntity result =
          await exerciseRepository.endPractice(endExerciseBody);
      emit(state.copyWith(
        endPracticeStatus: LoadStatus.success,
        endPracticeResponse: result,
      ));
    } catch (e) {
      emit(state.copyWith(endPracticeStatus: LoadStatus.failure));
    }
  }
}
