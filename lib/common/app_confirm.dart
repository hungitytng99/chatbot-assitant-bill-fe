import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/generated/l10n.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_button.dart';

class AppConfirm extends StatefulWidget {
  final String? description;
  final VoidCallback onConfirm;

  const AppConfirm({
    Key? key,
    this.description,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<AppConfirm> createState() => _AppConfirmState();
}

class _AppConfirmState extends State<AppConfirm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            height: 50,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
                  child: Text(
                    "Vui lòng xác nhận",
                    style: AppTextStyle.blackS18Bold.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                widget.description ?? "Bạn chắc chắn chứ?",
                textAlign: TextAlign.center,
                style: AppTextStyle.blackS16.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AppButton(
            title: S.current.common_confirm.toUpperCase(),
            textStyle: AppTextStyle.whiteS16.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            width: 250,
            height: 50,
            onPressed: () {
              widget.onConfirm();
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
