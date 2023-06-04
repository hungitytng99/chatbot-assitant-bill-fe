part of 'exercise_review_cubit.dart';

class ExerciseReviewState extends Equatable {
  final LoadStatus getListReviewKeywordsStatus;
  final ReviewKeywordsEntity? reviewKeywords;
  final LoadStatus feedbackExerciseStatus;

  @override
  List<Object?> get props => [
        getListReviewKeywordsStatus,
        reviewKeywords,
        feedbackExerciseStatus,
      ];

  const ExerciseReviewState({
    this.getListReviewKeywordsStatus = LoadStatus.initial,
    this.reviewKeywords,
    this.feedbackExerciseStatus = LoadStatus.initial,
  });

  ExerciseReviewState copyWith({
    LoadStatus? getListReviewKeywordsStatus,
    ReviewKeywordsEntity? reviewKeywords,
    LoadStatus? feedbackExerciseStatus,
  }) {
    return ExerciseReviewState(
      getListReviewKeywordsStatus:
          getListReviewKeywordsStatus ?? this.getListReviewKeywordsStatus,
      reviewKeywords: reviewKeywords ?? this.reviewKeywords,
      feedbackExerciseStatus:
          feedbackExerciseStatus ?? this.feedbackExerciseStatus,
    );
  }
}
