import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/components/search_text_field.dart';
import 'package:ihz_bql/ui/pages/course/course_item/course_item.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CourseListPage extends StatefulWidget {
  ExpertEntity? expertEntity;
  final Function? resetExpertEntity;
  CourseListPage({
    Key? key,
    this.expertEntity,
    this.resetExpertEntity,
  }) : super(key: key);
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  TextEditingController searchExerciseController = TextEditingController();
  bool isShowDeleteIcon = false;
  late CourseListCubit _courseListCubit;
  int activeHashTagIndex = 0;
  bool isFilterByExpert = true;
  Timer? _searchExerciseDebounce;

  final PagingController<int, ExerciseEntity> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _courseListCubit = BlocProvider.of<CourseListCubit>(context);
    _courseListCubit.getHashTags();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<ExerciseEntity> chatConversation =
          await _courseListCubit.getExercisesByFilter(
        page: pageKey + 1,
        hashtag: _courseListCubit.state.hashtags.isEmpty
            ? null
            : _courseListCubit.state.hashtags[activeHashTagIndex],
        query: searchExerciseController.text,
        expertId: widget.expertEntity?.id,
      );
      final bool isLastPage = pageKey > 3;
      if (isLastPage) {
        _pagingController.appendLastPage(chatConversation);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(chatConversation, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseListCubit, CourseListState>(
      listener: (context, state) {
        if (state.getHashtagStatus == LoadStatus.success) {}
      },
      listenWhen: (prev, current) {
        return prev.getHashtagStatus != current.getHashtagStatus;
      },
      child: _buildBody(),
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
                    Visibility(
                      visible: isFilterByExpert && widget.expertEntity != null,
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, top: 4),
                        child: Row(
                          children: [
                            const Text("Lọc bài tập của "),
                            Text(
                              widget.expertEntity?.name ?? "",
                              style: AppTextStyle.blackS14Bold,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFilterByExpert = false;
                                });
                                widget.resetExpertEntity!();
                                widget.expertEntity = null;
                                _pagingController.refresh();
                              },
                              child: const Icon(
                                Icons.highlight_off,
                                color: AppColors.textBlack,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
        textEditingController: searchExerciseController,
        onChanged: (text) {
          // cubit!.onSearch(text);
          setState(() {
            if (text.isEmpty) {
              isShowDeleteIcon = false;
            } else {
              isShowDeleteIcon = true;
            }
          });
          if (_searchExerciseDebounce?.isActive ?? false) {
            _searchExerciseDebounce?.cancel();
          }
          _searchExerciseDebounce =
              Timer(const Duration(milliseconds: 400), () {
            _pagingController.refresh();
          });
        },
        onSubmitted: (text) {},
        onDelete: () {
          searchExerciseController.text = "";
          _pagingController.refresh();
        },
        isShowDeleteIcon: isShowDeleteIcon,
      ),
    );
  }

  Widget _buildListTags() {
    return BlocBuilder<CourseListCubit, CourseListState>(
      buildWhen: (prev, current) =>
          prev.getHashtagStatus != current.getHashtagStatus,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Row(
              children: <Widget>[
                for (int i = 0; i < state.hashtags.length; i++) ...{
                  InkWell(
                    onTap: () {
                      setState(() {
                        activeHashTagIndex = i;
                      });
                      _pagingController.refresh();
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
                        state.hashtags[i],
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
      },
    );
  }

  Widget _buildListCourses() {
    double normalWidgetHeight = MediaQuery.of(context).size.height - 238;
    if(widget.expertEntity != null) {
      normalWidgetHeight = normalWidgetHeight - 22;
    }
    return Container(
      height: normalWidgetHeight,
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 14,
        right: 14,
        top: 12,
      ),
      child: PagedListView<int, ExerciseEntity>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ExerciseEntity>(
          newPageProgressIndicatorBuilder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                margin: const EdgeInsets.only(top: 10, bottom: 6),
                height: 14.0,
                width: 14.0,
              ),
            ],
          ),
          firstPageErrorIndicatorBuilder: (context) => const Center(
            child: Text("Một lỗi đã xảy ra"),
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
            child: Text("Không tìm thấy bài tập"),
          ),
          itemBuilder: (context, exercise, index) {
            return InkWell(
              onTap: () {
                Application.router.navigateTo(
                  context,
                  Routes.courseDetail,
                  rootNavigator: true,
                  routeSettings: RouteSettings(
                    arguments: CourseDetailArgument(
                      exerciseEntity: exercise,
                    ),
                  ),
                );
              },
              child: CourseItem(
                exerciseEntity: exercise,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CourseDetailArgument {
  ExerciseEntity exerciseEntity;
  CourseDetailArgument({
    required this.exerciseEntity,
  });
}
