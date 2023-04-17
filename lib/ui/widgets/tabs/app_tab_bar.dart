import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_theme.dart';

/// tabController = TabController(length: 2, vsync: this)
/// Page with TickerProviderStateMixin

class AppTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<String> tabItems;
  final bool isScrollable;

  const AppTabBar({
    Key? key,
    this.tabController,
    this.tabItems = const [],
    this.isScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      child: TabBar(
        isScrollable: isScrollable,
        controller: tabController,
        tabs: buildTabItems(),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textGrayDarker,
        indicator: BoxDecoration(
          color: AppColors.primaryLighter,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        indicatorWeight: 0,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFEBEBEB),
        borderRadius: BorderRadius.all(Radius.circular(19)),
      ),
    );
  }

  List<Widget> buildTabItems() {
    List<Widget> items = [];
    for (int i = 0; i < (tabItems).length; i++) {
      items.add(buildTabItem(tabItems[i], i));
    }
    return items;
  }

  Widget buildTabItem(String title, int index) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14),
    );
  }
}
