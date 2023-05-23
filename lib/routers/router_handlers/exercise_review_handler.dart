
import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/course/exercise_review/exercise_review_cubit.dart';
import 'package:ihz_bql/ui/pages/course/exercise_review/exercise_review_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler exerciseReviewHandler = new Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return ExerciseReviewCubit();
    },
    child: ExerciseReviewPage(),
  );
});
  
