import 'package:fluro/fluro.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/ui/pages/course/course_detail/course_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/course/course_detail/course_detail_page.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';

Handler courseDetailHandler = Handler(handlerFunc: (context, parameters) {
  CourseDetailArgument courseDetail =
      context!.arguments as CourseDetailArgument;
  return BlocProvider(
    create: (context) {
      return CourseDetailCubit();
    },
    child: CourseDetailPage(courseDetail: courseDetail),
  );
});
