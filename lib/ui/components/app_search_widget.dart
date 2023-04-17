import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_vectors.dart';
import 'package:ihz_bql/ui/components/my_app_search.dart';

class AppSearchWidget extends StatelessWidget {
  final String? title;
  final Widget? child;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onDelete;
  final VoidCallback? onBackPressed;
  final bool isBack;
  final bool safeAreaBottom;
  final String? hintText;

  const AppSearchWidget({
    Key? key,
    this.title,
    this.child,
    this.textEditingController,
    this.onSubmitted,
    this.onDelete,
    this.onBackPressed,
    this.isBack = true,
    this.safeAreaBottom = true,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildHeaderBackground(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                MyAppSearchBar(
                  title: title ?? "",
                  textEditingController: textEditingController,
                  onSubmitted: onSubmitted,
                  onDelete: onDelete,
                  onBackPressed: () {
                    isBack ? Navigator.pop(context) : onBackPressed!();
                  },
                  hintText: hintText,
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    child: Container(
                      child: Stack(
                        children: [
                          buildFooterBackground(),
                          SafeArea(
                            child: child!,
                            bottom: safeAreaBottom,
                          ),
                        ],
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderBackground() {
    return Column(
      children: [
        Container(
            color: Colors.red,
            width: double.infinity,
            child: SvgPicture.asset(
              AppVectors.bgRequestManagementBanner,
              fit: BoxFit.cover,
              color: AppColors.primary,
            )),
        const Spacer(),
      ],
    );
  }

  Widget buildFooterBackground() {
    return Column(
      children: [
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            AppImages.bgHomeFooter,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
