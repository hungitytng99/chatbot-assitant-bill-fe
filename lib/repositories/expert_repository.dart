import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/models/entities/upcomming_expert_entity.dart';
import 'package:ihz_bql/networks/api_client.dart';

abstract class ExpertRepository {
  Future<List<ExpertEntity>> getActive();
  Future<UpCommingExpertEntity> getUpcomingExperts();
}

class ExpertRepositoryImpl extends ExpertRepository {
  late ApiClient _apiClient;

  ExpertRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }
  @override
  Future<List<ExpertEntity>> getActive() {
    return _apiClient.getActiveExperts();
  }

  @override
  Future<UpCommingExpertEntity> getUpcomingExperts() {
    return _apiClient.getUpcomingExperts();
  }
}
