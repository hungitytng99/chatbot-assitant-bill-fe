import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_dimens.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    Key? key,
    bool showBackButton = true,
    VoidCallback? onBackPressed,
    String title = "",
    Color? backgroundColor,
    List<Widget> rightActions = const [],
  }) : super(
          key: key,
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          toolbarHeight: AppDimens.appBarHeight,
          elevation: 0,
          backgroundColor: backgroundColor,
          leading: showBackButton
              ? IconButton(
                  onPressed: onBackPressed,
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ))
              : null,
          actions: rightActions,
        );
}
