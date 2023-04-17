import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_back_button.dart';

class MyAppBarBlack extends AppBar {
  MyAppBarBlack({
    Key? key,
    String title = '',
  }) : super(
            titleSpacing: 0,
            key: key,
            elevation: 0,
            leading: const SizedBox(),
            leadingWidth: 0,
            backgroundColor: Colors.transparent,
            title: Container(
              height: 144,
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBackButton(
                    onBackPressed: () {
                      Get.back();
                    },
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: AppTextStyle.blackS16Bold,
                      ),
                    ),
                  ),
                ],
              ),
            ));

}
