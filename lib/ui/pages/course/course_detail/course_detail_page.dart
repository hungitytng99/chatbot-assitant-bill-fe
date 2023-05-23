import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/ui/pages/common/youtube_player/youtube_player.dart';
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
  @override
  void initState() {
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
    return AppYoutubePlayer(exerciseEntity: widget.courseDetail.exerciseEntity);
  }
}
