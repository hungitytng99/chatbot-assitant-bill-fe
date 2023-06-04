import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/monthly_practice_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/diary_repository.dart';
part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryRepository diaryRepository;

  DiaryCubit({
    required this.diaryRepository,
  }) : super(const DiaryState());

  Future<void> getMonthlyHistoryPractices({
    required String startDate,
    required String endDate,
  }) async {
    emit(state.copyWith(getMonthlyHistoryPracticesStatus: LoadStatus.loading));
    try {
      final MonthlyPracticeEntity history =
          await diaryRepository.getMonthlyHistoryPractices(
        startDate: startDate,
        endDate: endDate,
      );

      emit(state.copyWith(
        getMonthlyHistoryPracticesStatus: LoadStatus.success,
        monthlyHistoryPractices: history,
      ));
    } catch (e) {
      emit(
          state.copyWith(getMonthlyHistoryPracticesStatus: LoadStatus.failure));
    }
  }
}
