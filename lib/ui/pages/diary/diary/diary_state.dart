part of 'diary_cubit.dart';

class DiaryState extends Equatable {
  final LoadStatus getMonthlyHistoryPracticesStatus;
  final MonthlyPracticeEntity? monthlyHistoryPractices;

  @override
  List<Object?> get props => [
        getMonthlyHistoryPracticesStatus,
        monthlyHistoryPractices,
      ];

  const DiaryState({
    this.getMonthlyHistoryPracticesStatus = LoadStatus.initial,
    this.monthlyHistoryPractices,
  });

  DiaryState copyWith({
    LoadStatus? getMonthlyHistoryPracticesStatus,
    MonthlyPracticeEntity? monthlyHistoryPractices,
  }) {
    return DiaryState(
      getMonthlyHistoryPracticesStatus: getMonthlyHistoryPracticesStatus ??
          this.getMonthlyHistoryPracticesStatus,
      monthlyHistoryPractices:
          monthlyHistoryPractices ?? this.monthlyHistoryPractices,
    );
  }
}
