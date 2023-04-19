import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';

class UserAvatarItem extends StatefulWidget {
  double size;
  UserOnlineStatusEnum status;
  UserAvatarItem({
    this.size = 55,
    this.status = UserOnlineStatusEnum.ONLINE,
    Key? key,
  }) : super(key: key);
  @override
  _UserAvatarItemState createState() => _UserAvatarItemState();
}

class _UserAvatarItemState extends State<UserAvatarItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppCacheImage(
          width: widget.size,
          height: widget.size,
          borderRadius: widget.size / 2,
          url: "https://picsum.photos/200",
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: widget.status == UserOnlineStatusEnum.ONLINE
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.greenRequest,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ))
              : Container(),
        ),
      ],
    );
  }
}
