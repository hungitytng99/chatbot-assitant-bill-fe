import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';

class UserAvatarCardHorizontal extends StatefulWidget {
  double avatarSize;
  UserOnlineStatusEnum status;
  String userFullName;
  String description;

  UserAvatarCardHorizontal({
    required this.userFullName,
    this.avatarSize = 55,
    this.status = UserOnlineStatusEnum.ONLINE,
    this.description = 'Bắt đầu trò chuyện ngay nào',
    Key? key,
  }) : super(key: key);
  @override
  _UserAvatarCardHorizontalState createState() =>
      _UserAvatarCardHorizontalState();
}

class _UserAvatarCardHorizontalState extends State<UserAvatarCardHorizontal> {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: UserAvatarItem(
            size: widget.avatarSize,
            status: widget.status,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              // width: MediaQuery.of(context).size.width - widget.avatarSize - 30,
              child: Text(
                widget.userFullName,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.blackS14W600,
                maxLines: 1,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // width: MediaQuery.of(context).size.width - widget.avatarSize - 70,
                  child: Text(
                    widget.description,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.greyS12W400,
                    maxLines: 1,
                  ),
                ),
                Text(
                  ' • 12:39',
                  style: AppTextStyle.greyS12W400,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
