import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';

class DialogSuccessWidget extends StatefulWidget {
  final bool isManagement;
  final String jobCode;
  final String title;
  final VoidCallback? onTapClose;

  const DialogSuccessWidget({
    Key? key,
    this.jobCode = "",
    this.isManagement = false,
    this.title = "",
    this.onTapClose,
  }) : super(key: key);

  @override
  State<DialogSuccessWidget> createState() => _DialogSuccessWidgetState();
}

class _DialogSuccessWidgetState extends State<DialogSuccessWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
          widget.onTapClose?.call();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mounted) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
            widget.onTapClose?.call();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            ///do nothing
          },
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingNormal,
                  vertical: AppDimens.paddingNormal),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimens.marginExtra,
                  vertical: AppDimens.marginS5),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppDimens.paddingSmall),
                      child: SvgPicture.asset(
                        widget.isManagement ? AppVectors.icAssignSuccess : AppVectors.icCheckSuccess,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.paddingS5),
                      child:
                      widget.isManagement
                      ? RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Mã công việc ',
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(text: widget.jobCode, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const TextSpan(text: ' được giao thành công'),
                            ],
                          ),
                      ) : Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.blackS14Regular,
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
