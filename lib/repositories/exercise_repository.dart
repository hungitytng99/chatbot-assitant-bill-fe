import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/networks/api_client.dart';

abstract class ExerciseRepository {
  Future<List<ExerciseEntity>> getExercises();
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
}
