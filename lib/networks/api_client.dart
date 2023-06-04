import 'package:dio/dio.dart';
import 'package:ihz_bql/models/entities/auth_token_entity.dart';
import 'package:ihz_bql/models/entities/end_practice_response_entity.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/models/entities/exercise_filter_entity.dart';
import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/models/entities/monthly_practice_entity.dart';
import 'package:ihz_bql/models/entities/review_keywords_entity.dart';
import 'package:ihz_bql/models/entities/upcomming_expert_entity.dart';
import 'package:ihz_bql/models/entities/user_entity.dart';
import 'package:ihz_bql/models/params/auth/sign_up_body.dart';
import 'package:ihz_bql/models/params/end_exercise_body.dart';
import 'package:ihz_bql/models/params/feedback_exercise_body.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/signup")
  Future<UserEntity> signUp(@Body() SignUpBody body);

  @MultiPart()
  @POST("/login")
  Future<AuthTokenEntity> signIn(
      @Part() String username, @Part() String password);

  @GET("/me")
  Future<UserEntity> getMyProfile();

  @GET("/experts")
  Future<List<ExpertEntity>> getActiveExperts();

  @GET("/exercises")
  Future<List<ExerciseEntity>> getExercises();

  @GET("/exercises/filter")
  Future<ExerciseFilterEntity> getFilteredExercises(
    @Query('expert_id') String? expertId,
    @Query('query') String? query,
    @Query('hashtag') String? hashtag,
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @GET("/hashtags")
  Future<List<String>> getHashtags();

  @POST("/user/practice/end")
  Future<EndPracticeResponseEntity> endPractice(
      @Body() EndExerciseBody endExerciseBody);

  @POST("/user/practice/feedback")
  Future<String> reviewPractice();

  @GET("/experts/upcoming")
  Future<UpCommingExpertEntity> getUpcomingExperts();

  @GET("/user/practice/feedback/keywords")
  Future<ReviewKeywordsEntity> getReviewExerciseKeywords();

  @POST("/user/practice/feedback")
  Future<String> feedBackExercisePractice(@Body() FeedbackExerciseBody body);

  @GET("/user/practice/monthly-history")
  Future<MonthlyPracticeEntity> getMonthlyHistoryPractices(
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
  );
}
