import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';

class AppCustomTabBarController extends ValueNotifier<int> {
  AppCustomTabBarController(int value) : super(value);

  int get index => value;

  set index(int newValue) {
    value = newValue;
  }
}

class AppCustomTabBar extends StatefulWidget {
  final TabController tabController;

  final List<Widget> listWidget;

  final List<String> listTitle;

  final bool isLeftAlignmentItem;

  const AppCustomTabBar({
    Key? key,
    required this.listTitle,
    required this.listWidget,
    required this.tabController,
    this.isLeftAlignmentItem = false,
  }) : super(key: key);

  @override
  State<AppCustomTabBar> createState() => _AppCustomTabBarState();
}

class _AppCustomTabBarState extends State<AppCustomTabBar> {
  AppCustomTabBarController controllerMenu = AppCustomTabBarController(0);
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    if (widget.listTitle.length != widget.listWidget.length) {
      throw Exception(
          "The number of titles must be equal to the number of widgets");
    }
    _scrollController = ScrollController();
    widget.tabController.addListener(() {
      controllerMenu.value = widget.tabController.index;
      if (widget.listTitle.length > 3) {
        _scrollController.animateTo(widget.tabController.index.toDouble() * 60,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn);
      }
    });
  }

  @override
  void dispose() {
    controllerMenu.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isLeftAlignmentItem
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingS12, vertical: AppDimens.paddingS12),
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Wrap(
              children: _buildListItem(),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: widget.listWidget,
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }

  List<Widget> _buildListItem() {
    List<Widget> listItemWidget = [];
    for (int i = 0; i < widget.listTitle.length; i++) {
      listItemWidget.add(TabBarItem(
        controllerMenu: controllerMenu,
        tabController: widget.tabController,
        title: widget.listTitle[i],
        index: i,
      ));
      if (i != widget.listTitle.length - 1) {
        listItemWidget.add(const SizedBox(width: 8));
      }
    }
    return listItemWidget;
  }
}

class TabBarItem extends StatelessWidget {
  final TabController tabController;
  final AppCustomTabBarController controllerMenu;
  final String title;
  final int index;

  const TabBarItem({
    Key? key,
    required this.tabController,
    required this.title,
    required this.index,
    required this.controllerMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tabController.animateTo(index);
      },
      child: ValueListenableBuilder(
        valueListenable: controllerMenu,
        builder: (BuildContext context, value, Widget? child) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.paddingS7,
              horizontal: AppDimens.paddingS15,
            ),
            decoration: controllerMenu.value == index
                ? BoxDecoration(
                    color: AppColors.primaryLighter,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  )
                : const BoxDecoration(
                    color: AppColors.grayF4,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
            child: Align(
              alignment: Alignment.center,
              child: AppLabelText(
                labelText: title,
                labelStyle: controllerMenu.value == index
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.main,
                        fontSize: 14)
                    : AppTextStyle.blackS14Regular,
              ),
            ),
          );
        },
        child: Container(),
      ),
    );
  }
}
