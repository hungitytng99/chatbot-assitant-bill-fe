import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/models/entities/exercise_filter_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/exercise_repository.dart';
import 'package:ihz_bql/repositories/hashtag_repository.dart';
part 'course_list_state.dart';

class CourseListCubit extends Cubit<CourseListState> {
  ExerciseRepository exerciseRepository;
  HashTagsRepository hashTagsRepository;
  CourseListCubit({
    required this.exerciseRepository,
    required this.hashTagsRepository,
  }) : super(CourseListState());

  Future<void> getHashTags() async {
    emit(state.copyWith(getHashtagStatus: LoadStatus.loading));
    try {
      final List<String> result = await hashTagsRepository.getHashTags();

      emit(state.copyWith(
        getHashtagStatus: LoadStatus.success,
        hashtags: result,
      ));
    } catch (e) {
      emit(state.copyWith(getHashtagStatus: LoadStatus.failure));
    }
  }

  Future<List<ExerciseEntity>> getExercisesByFilter({
    String? expertId,
    String? query,
    String? hashtag,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final ExerciseFilterEntity result =
          await exerciseRepository.getFilterExercises(
        expertId: expertId,
        query: query,
        hashtag: hashtag,
        page: page,
        limit: limit,
      );
      return result.exercises;
    } catch (e) {
      return [];
    }
  }
}
