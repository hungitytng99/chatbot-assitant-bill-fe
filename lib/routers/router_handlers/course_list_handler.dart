import 'package:fluro/fluro.dart';
import 'package:ihz_bql/repositories/exercise_repository.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_cubit.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler courseListHandler = Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      ExerciseRepository exerciseRepository =
          RepositoryProvider.of<ExerciseRepository>(context);
      return CourseListCubit(exerciseRepository: exerciseRepository);
    },
    child: const CourseListPage(),
  );
});
