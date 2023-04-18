import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_images.dart';


class OTPLayout extends StatelessWidget {
  final Widget body;
  final bool? isShowBack;
  final bool? isAvoidBottomInset;
  OTPLayout({Key? key, required this.body, this.isShowBack, this.isAvoidBottomInset}) : super(key: key);

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
          )),
      child: Scaffold(
        resizeToAvoidBottomInset: isAvoidBottomInset ?? true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Visibility(
                visible: isShowBack ?? true,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 38,
                    width: 38,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Colors.red,
                    ),
                  ),
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
