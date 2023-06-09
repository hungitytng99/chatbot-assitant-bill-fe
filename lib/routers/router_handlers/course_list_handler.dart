import 'package:fluro/fluro.dart';
import 'package:ihz_bql/repositories/exercise_repository.dart';
import 'package:ihz_bql/repositories/hashtag_repository.dart';
import 'package:ihz_bql/repositories/hashtag_repository.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_cubit.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/ui/pages/homepage/home_page.dart';

Handler courseListHandler = Handler(handlerFunc: (context, parameters) {
  HomePageArgument? args = context!.arguments as HomePageArgument?;
  return BlocProvider(
    create: (context) {
      ExerciseRepository exerciseRepository =
          RepositoryProvider.of<ExerciseRepository>(context);
      HashTagsRepository hashTagsRepository =
          RepositoryProvider.of<HashTagsRepository>(context);
      return CourseListCubit(
        exerciseRepository: exerciseRepository,
        hashTagsRepository: hashTagsRepository,
      );
    },
    child: CourseListPage(
      expertEntity: args?.expertEntity,
    ),
  );
});
