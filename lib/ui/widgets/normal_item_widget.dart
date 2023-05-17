import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/utils/date_utils.dart';

class NormalItemWidget extends StatelessWidget {
  final String? urlImage;
  final Color? bgColor;
  final VoidCallback? onPressed;
  final String? dateTimeCreate;
  final String? title;

  const NormalItemWidget({
    Key? key,
    this.urlImage,
    this.bgColor,
    this.onPressed,
    this.dateTimeCreate,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateTimeCrate = AppDateUtils.toDateAPIString(AppDateUtils.fromDateAPIString(dateTimeCreate ?? "") ?? DateTime.now());
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingS5),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.lineGray,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: urlImage ?? "",
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 2,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        AppImages.icAvatar,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateTimeCrate, style: AppTextStyle.greyS12),
                  const SizedBox(height: 8),
                  Text(title ?? "", style: AppTextStyle.blackS14Bold, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
