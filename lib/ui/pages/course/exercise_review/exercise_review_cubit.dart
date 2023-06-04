import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/review_keywords_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/params/feedback_exercise_body.dart';
import 'package:ihz_bql/repositories/exercise_repository.dart';
part 'exercise_review_state.dart';

class ExerciseReviewCubit extends Cubit<ExerciseReviewState> {
  ExerciseRepository exerciseRepository;
  ExerciseReviewCubit({
    required this.exerciseRepository,
  }) : super(ExerciseReviewState());

  Future<void> getHashTags() async {
    emit(state.copyWith(getListReviewKeywordsStatus: LoadStatus.loading));
    try {
      final ReviewKeywordsEntity keywords =
          await exerciseRepository.getReviewExerciseKeywords();

      emit(state.copyWith(
        getListReviewKeywordsStatus: LoadStatus.success,
        reviewKeywords: keywords,
      ));
    } catch (e) {
      emit(state.copyWith(getListReviewKeywordsStatus: LoadStatus.failure));
    }
  }

  Future<void> feedbackExercise({
    required FeedbackExerciseBody body,
  }) async {
    emit(state.copyWith(feedbackExerciseStatus: LoadStatus.loading));
    try {
      final String feedbackResponse =
          await exerciseRepository.feedBackExercisePractice(body);

      emit(state.copyWith(
        feedbackExerciseStatus: LoadStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(feedbackExerciseStatus: LoadStatus.failure));
    }
  }
}
