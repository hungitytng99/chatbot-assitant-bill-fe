import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/params/end_exercise_body.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/common/youtube_player/youtube_player.dart';
import 'package:ihz_bql/ui/pages/course/course_detail/course_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';
import 'package:ihz_bql/ui/widgets/commons/app_snackbar.dart';

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
    return BlocConsumer<CourseDetailCubit, CourseDetailState>(
        bloc: _courseDetailCubit,
        listenWhen: (prev, current) {
          return prev.endPracticeStatus != current.endPracticeStatus;
        },
        listener: (context, state) {
          if (state.endPracticeStatus == LoadStatus.failure) {
            AppSnackbar.showError(
              title: 'Lỗi',
              message: 'Một lỗi đã xảy ra khi đánh dấu sự luyện tập của bạn',
            );
            return;
          }
          if (state.endPracticeStatus == LoadStatus.success) {
            Application.router.navigateTo(
              context,
              Routes.exerciseReview,
              routeSettings: RouteSettings(
                arguments: EndPracticeArgument(
                  practiceId: state.endPracticeResponse?.id ?? "",
                  exerciseId: state.endPracticeResponse?.exerciseId ?? "",
                  exerciseName: state.endPracticeResponse?.exerciseName ?? "",
                ),
              ),
            );
            return;
          }
        },
        builder: (context, state) {
          return AppYoutubePlayer(
            exerciseEntity: widget.courseDetail.exerciseEntity,
            onEndPractice: (EndExerciseBody endExerciseBody) {
              _courseDetailCubit.endPractices(endExerciseBody);
            },
            isRequestEndPractice: state.endPracticeStatus,
          );
        });
  }
}

class EndPracticeArgument {
  String practiceId;
  String exerciseId;
  String exerciseName;
  EndPracticeArgument({
    required this.practiceId,
    required this.exerciseId,
    required this.exerciseName,
  });
}
