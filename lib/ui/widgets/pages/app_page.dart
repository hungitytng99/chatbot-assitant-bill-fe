import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_shadow.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_back_button.dart';

class AppPage extends StatelessWidget {
  final String appBarTitle;
  final Widget? appBarLeading;
  final Widget? appBarTrailing;
  final VoidCallback? onBackPressed;
  final Widget? appBar;
  final Widget body;
  final Widget? endDrawer;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? bodyColor;
  final Key? scaffoldKey;
  final bool enableTopBodyShadow;
  final bool showBackButton;
  final double bodyMarginAppbar;

  const AppPage({
    Key? key,
    this.scaffoldKey,
    this.appBarTitle = '',
    this.appBarLeading,
    this.appBarTrailing,
    this.onBackPressed,
    required this.body,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.bodyColor = AppColors.white,
    this.enableTopBodyShadow = false,
    this.showBackButton = true,
    this.bodyMarginAppbar = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        shadowColor: null,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 144,
              decoration: BoxDecoration(
                color: AppColors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.appBarGradientTop,
                    AppColors.appBarGradientBottom,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: kToolbarHeight,
                    maxHeight: 72,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: AppDimens.paddingS8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      appBarLeading ??
                          (showBackButton
                              ? AppBackButton(
                                  onBackPressed: onBackPressed ??
                                      Navigator.of(context).pop,
                                  color: Colors.white,
                                )
                              : const SizedBox(
                                  height: 40,
                                  width: AppDimens.paddingNormal,
                                )),
                      Expanded(
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: appBar ??
                              Text(
                                appBarTitle,
                                style: AppTextStyle.whiteS16Bold,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                        ),
                      ),
                      appBarTrailing ?? const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(height: bodyMarginAppbar),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: enableTopBodyShadow
                              ? BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                  boxShadow: AppShadow.pageBoxShadow,
                                  color: Colors.white)
                              : null,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            child: Container(
                              child: body,
                              decoration: BoxDecoration(
                                color: bodyColor,
                                borderRadius: enableTopBodyShadow
                                    ? const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      )
                                    : BorderRadius.zero,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
