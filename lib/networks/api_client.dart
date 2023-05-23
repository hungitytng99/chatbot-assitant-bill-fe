import 'package:dio/dio.dart';
import 'package:ihz_bql/models/entities/auth_token_entity.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/models/entities/user_entity.dart';
import 'package:ihz_bql/models/params/auth/sign_up_body.dart';
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

  @GET("/experts")
  Future<List<ExpertEntity>> getActiveExperts();

  @GET("/exercises")
  Future<List<ExerciseEntity>> getExercises();

  @GET("/me")
  Future<UserEntity> getMyProfile();
}
