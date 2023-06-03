import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/models/params/end_exercise_body.dart';
import 'package:ihz_bql/ui/pages/common/youtube_player/youtube_player.dart';
import 'package:ihz_bql/ui/pages/course/course_detail/course_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';

class CourseDetailPage extends StatefulWidget {
  CourseDetailArgument courseDetail;
  CourseDetailPage({
    Key? key,
    required this.courseDetail,
  }) : super(key: key);
  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late CourseDetailCubit _courseDetailCubit;
  @override
  void initState() {
    _courseDetailCubit = BlocProvider.of<CourseDetailCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return AppYoutubePlayer(
      exerciseEntity: widget.courseDetail.exerciseEntity,
      onEndPractice: (EndExerciseBody endExerciseBody) {
        _courseDetailCubit.endPractices(endExerciseBody);
      },
    );
  }
}
