import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';


class AppCacheImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit fit;
  final bool showLoading;

  const AppCacheImage({Key? key,
    this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.showLoading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isValidUrl = Uri.tryParse(url!)?.isAbsolute == true;
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: isValidUrl
          ? ClipRRect(
              child: url == null
                  ? Container()
                  : CachedNetworkImage(
                      imageUrl: url ?? '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        if (showLoading == true) {
                          return Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                backgroundColor: Colors.white,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.main),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                            ),
                          );
                        }
                      },
                      errorWidget: (context, url, error) {
                        return Image.network(
                          url,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceHolderImage(),
                          fit: fit,
                        );
                      },
                      fit: fit,
                    ),
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            )
          : _buildPlaceHolderImage(),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
    );
  }

  Widget _buildPlaceHolderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        // ignore: prefer_const_constructors
        color: Color(0xFFe6e6e6),
        child: Center(
          child: Image.asset(
            AppImages.icImagePlaceholder,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}

class AppCircleAvatar extends StatelessWidget {
  final String? url;
  final double? size;

  const AppCircleAvatar({this.url, this.size});

  @override
  Widget build(BuildContext context) {
    bool isValidUrl = Uri.tryParse(url ?? "")?.isAbsolute == true;
    return Container(
      width: size ?? double.infinity,
      height: size ?? double.infinity,
      child: isValidUrl
          ? ClipRRect(
              child: CachedNetworkImage(
                imageUrl: url ?? '',
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
              borderRadius: BorderRadius.circular(size! / 2),
            )
          : SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                AppImages.icAvatar,
                fit: BoxFit.cover,
              ),
            ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(size! / 2),
      ),
    );
  }
}
