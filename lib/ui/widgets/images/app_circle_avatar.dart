import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_images.dart';

class AppCircleAvatar extends StatelessWidget {
  final String url;
  final double? size;

  const AppCircleAvatar({
    Key? key,
    this.url = "",
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isValidUrl = Uri.tryParse(url)?.isAbsolute == true;
    return Container(
      width: size ?? double.infinity,
      height: size ?? double.infinity,
      child: isValidUrl
          ? ClipRRect(
              child: CachedNetworkImage(
                imageUrl: url,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return SizedBox(
                    width: size,
                    height: size,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 2,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey,
                  );
                },
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular((size ?? 0) / 2),
            )
          : ClipRRect(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey,
                ///ảnh svg bị khuyết mất phần dưới nên sử dụng ảnh png
                child: Image.asset(AppImages.icUser),
              ),
              borderRadius: BorderRadius.circular((size ?? 0) / 2),
            ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular((size ?? 0) / 2),
      ),
    );
  }
}
