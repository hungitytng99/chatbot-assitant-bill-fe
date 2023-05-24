import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/models/entities/exercise_filter_entity.dart';
import 'package:ihz_bql/networks/api_client.dart';

abstract class HashTagsRepository {
  Future<List<String>> getHashTags();
}

class HashTagsRepositoryImpl extends HashTagsRepository {
  late ApiClient _apiClient;

  HashTagsRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<List<String>> getHashTags() {
    return _apiClient.getHashtags();
  }
}
