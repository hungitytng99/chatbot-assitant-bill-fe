import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/components/search_text_field.dart';
import 'package:ihz_bql/ui/pages/course/course_item/course_item.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_cubit.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({
    Key? key,
  }) : super(key: key);
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  TextEditingController textEditingController = TextEditingController();
  bool isShowDeleteIcon = false;
  late CourseListCubit _courseListCubit;
  int activeHashTagIndex = 0;

  @override
  void initState() {
    _courseListCubit = BlocProvider.of<CourseListCubit>(context);
    _courseListCubit.getExercises();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListCubit, CourseListState>(
      buildWhen: (prev, current) =>
          prev.getExercisesStatus != current.getExercisesStatus,
      builder: (context, state) {
        if (state.getExercisesStatus == LoadStatus.loading ||
            state.getExercisesStatus == LoadStatus.initial) {
          return const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.getExercisesStatus == LoadStatus.success) {
          return _buildBody();
        } else {
          return const Center(
            child: Text("Một lỗi đã xảy ra"),
          );
        }
      },
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildSearchBar(),
                    _buildListTags(),
                    _buildListCourses(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 4,
        bottom: 6,
        left: 14,
        right: 14,
      ),
      height: 42,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          width: 1,
          color: AppColors.lineGray,
        ),
      ),
      child: SearchTextField(
        hintText: "Hãy cùng khám phá nào?",
        height: 42,
        hintStyle: AppTextStyle.greyS14.copyWith(
          fontSize: 13,
        ),
        textEditingController: textEditingController,
        onChanged: (text) {
          // cubit!.onSearch(text);
          setState(() {
            if (text.isEmpty) {
              isShowDeleteIcon = false;
            } else {
              isShowDeleteIcon = true;
            }
          });
        },
        onSubmitted: (text) {},
        onDelete: () {
          textEditingController.text = "";
        },
        isShowDeleteIcon: isShowDeleteIcon,
      ),
    );
  }

  Widget _buildListTags() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Row(
          children: <Widget>[
            for (int i = 0; i < 10; i++) ...{
              InkWell(
                onTap: () {
                  setState(() {
                    activeHashTagIndex = i;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 6,
                    left: 12,
                    bottom: 6,
                    right: 12,
                  ),
                  margin: const EdgeInsets.only(
                    right: 6,
                  ),
                  decoration: activeHashTagIndex == i
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.black,
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.backgroundGray,
                        ),
                  child: Text(
                    'Hash tag',
                    style: activeHashTagIndex == i
                        ? AppTextStyle.whiteS14Regular
                        : AppTextStyle.blackS14Regular,
                  ),
                ),
              )
            }
          ],
        ),
      ),
    );
  }

  Widget _buildListCourses() {
    return BlocBuilder<CourseListCubit, CourseListState>(
        buildWhen: (prev, current) =>
            prev.getExercisesStatus != current.getExercisesStatus,
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height - 238,
            width: double.infinity,
            margin: const EdgeInsets.only(
              left: 14,
              right: 14,
              top: 12,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < state.exercises.length; i++) ...{
                    InkWell(
                      onTap: () {
                        Application.router.navigateTo(
                          context,
                          Routes.courseDetail,
                          rootNavigator: true,
                          routeSettings: RouteSettings(
                            arguments: CourseDetailArgument(
                              exerciseEntity: state.exercises[i],
                            ),
                          ),
                        );
                      },
                      child: CourseItem(
                        exerciseEntity: state.exercises[i],
                      ),
                    ),
                  }
                ],
              ),
            ),
          );
        });
  }
}

class CourseDetailArgument {
  ExerciseEntity exerciseEntity;
  CourseDetailArgument({
    required this.exerciseEntity,
  });
}
