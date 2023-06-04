import 'package:ihz_bql/models/entities/monthly_practice_entity.dart';
import 'package:ihz_bql/networks/api_client.dart';

abstract class DiaryRepository {
  Future<MonthlyPracticeEntity> getMonthlyHistoryPractices(
      {required String startDate, required String endDate});
}

class DiaryRepositoryImpl extends DiaryRepository {
  late ApiClient _apiClient;

  DiaryRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }
  @override
  Future<MonthlyPracticeEntity> getMonthlyHistoryPractices(
      {required String startDate, required String endDate}) {
    return _apiClient.getMonthlyHistoryPractices(
      startDate,
      endDate,
    );
  }
}
