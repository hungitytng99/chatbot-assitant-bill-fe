import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/components/search_text_field.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_vertical.dart';
import 'package:ihz_bql/ui/pages/course/course_item/course_item.dart';

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
    return _buildBody();
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
              Container(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 12,
                  bottom: 4,
                  right: 12,
                ),
                margin: const EdgeInsets.only(
                  right: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.lineGray,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Tất cả'),
              ),
            }
          ],
        ),
      ),
    );
  }

  Widget _buildListCourses() {
    return Container(
      height: MediaQuery.of(context).size.height - 236,
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
            for (int i = 0; i < 100; i++) ...{
              CourseItem(),
            }
          ],
        ),
      ),
    );
  }
}
