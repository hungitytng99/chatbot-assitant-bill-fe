import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/models/entities/exercise_filter_entity.dart';
import 'package:ihz_bql/models/entities/review_keywords_entity.dart';
import 'package:ihz_bql/models/params/end_exercise_body.dart';
import 'package:ihz_bql/models/params/feedback_exercise_body.dart';
import 'package:ihz_bql/networks/api_client.dart';

abstract class ExerciseRepository {
  Future<List<ExerciseEntity>> getExercises();
  Future<ExerciseFilterEntity> getFilterExercises({
    String? expertId,
    String? query,
    String? hashtag,
    int page = 1,
    int limit = 10,
  });
  Future<EndPracticeResponseEntity> endPractice(
      EndExerciseBody endExerciseBody);
  Future<ReviewKeywordsEntity> getReviewExerciseKeywords();
  Future<String> feedBackExercisePractice(FeedbackExerciseBody body);
}

class ExerciseRepositoryImpl extends ExerciseRepository {
  late ApiClient _apiClient;

  ExerciseRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<List<ExerciseEntity>> getExercises() {
    return _apiClient.getExercises();
  }

  @override
  Future<ExerciseFilterEntity> getFilterExercises({
    String? expertId,
    String? query,
    String? hashtag,
    int page = 1,
    int limit = 10,
  }) {
    return _apiClient.getFilteredExercises(
      expertId,
      query,
      hashtag,
      page,
      limit,
    );
  }

  @override
  Future<EndPracticeResponseEntity> endPractice(
    EndExerciseBody endExerciseBody,
  ) {
    return _apiClient.endPractice(endExerciseBody);
  }

  @override
  Future<ReviewKeywordsEntity> getReviewExerciseKeywords() {
    return _apiClient.getReviewExerciseKeywords();
  }

  @override
  Future<String> feedBackExercisePractice(FeedbackExerciseBody body) {
    return _apiClient.feedBackExercisePractice(body);
  }
}
