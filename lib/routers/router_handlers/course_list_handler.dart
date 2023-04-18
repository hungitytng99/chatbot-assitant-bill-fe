
import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_cubit.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler courseListHandler = new Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return CourseListCubit();
    },
    child: CourseListPage(),
  );
});
  
