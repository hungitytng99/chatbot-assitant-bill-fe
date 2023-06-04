import 'package:fluro/fluro.dart';
import 'package:ihz_bql/repositories/exercise_repository.dart';
import 'package:ihz_bql/ui/pages/course/course_detail/course_detail_page.dart';
import 'package:ihz_bql/ui/pages/course/exercise_review/exercise_review_cubit.dart';
import 'package:ihz_bql/ui/pages/course/exercise_review/exercise_review_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler exerciseReviewHandler = Handler(handlerFunc: (context, parameters) {
  EndPracticeArgument courseDetail = context!.arguments as EndPracticeArgument;
  return BlocProvider(
    create: (context) {
      ExerciseRepository exerciseRepository =
          RepositoryProvider.of<ExerciseRepository>(context);
      return ExerciseReviewCubit(exerciseRepository: exerciseRepository);
    },
    child: ExerciseReviewPage(
      practiceId: courseDetail.practiceId,
      exerciseId: courseDetail.exerciseId,
      exerciseName: courseDetail.exerciseName,
    ),
  );
});
