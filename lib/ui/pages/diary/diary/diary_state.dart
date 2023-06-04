part of 'diary_cubit.dart';

class DiaryState extends Equatable {
  final LoadStatus getMonthlyHistoryPracticesStatus;
  final MonthlyPracticeEntity? monthlyHistoryPractices;
  final LoadStatus getDailyHistoryPracticesStatus;
  final DailyHistoryEntity? dailyHistoryEntity;

  @override
  List<Object?> get props => [
        getMonthlyHistoryPracticesStatus,
        getDailyHistoryPracticesStatus,
        monthlyHistoryPractices,
        dailyHistoryEntity,
      ];

  const DiaryState({
    this.getMonthlyHistoryPracticesStatus = LoadStatus.initial,
    this.getDailyHistoryPracticesStatus = LoadStatus.initial,
    this.monthlyHistoryPractices,
    this.dailyHistoryEntity,
  });

  DiaryState copyWith({
    LoadStatus? getMonthlyHistoryPracticesStatus,
    LoadStatus? getDailyHistoryPracticesStatus,
    MonthlyPracticeEntity? monthlyHistoryPractices,
    DailyHistoryEntity? dailyHistoryEntity,
  }) {
    return DiaryState(
      getMonthlyHistoryPracticesStatus: getMonthlyHistoryPracticesStatus ??
          this.getMonthlyHistoryPracticesStatus,
      monthlyHistoryPractices:
          monthlyHistoryPractices ?? this.monthlyHistoryPractices,
      dailyHistoryEntity: dailyHistoryEntity ?? this.dailyHistoryEntity,
      getDailyHistoryPracticesStatus:
          getDailyHistoryPracticesStatus ?? this.getDailyHistoryPracticesStatus,
    );
  }
}
