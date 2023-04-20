import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_back_button.dart';

class OTPLayout extends StatelessWidget {
  final Widget body;
  final bool? isShowBack;
  final bool? isAvoidBottomInset;
  OTPLayout(
      {Key? key, required this.body, this.isShowBack, this.isAvoidBottomInset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
            AppImages.icBack,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: isAvoidBottomInset ?? true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Visibility(
                visible: isShowBack ?? true,
                child: AppBackButton(
                  onBackPressed: Navigator.of(context).pop,
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.transparent,
        body: this.body,
      ),
    );
  }
}
