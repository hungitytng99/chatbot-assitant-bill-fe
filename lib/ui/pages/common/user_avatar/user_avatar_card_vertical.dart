import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';

class UserAvatarCardVertical extends StatefulWidget {
  double avatarSize;
  UserOnlineStatusEnum status;
  String userFullName;

  UserAvatarCardVertical({
    required this.userFullName,
    this.avatarSize = 55,
    this.status = UserOnlineStatusEnum.ONLINE,
    Key? key,
  }) : super(key: key);
  @override
  _UserAvatarCardVerticalState createState() => _UserAvatarCardVerticalState();
}

class _UserAvatarCardVerticalState extends State<UserAvatarCardVertical> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserAvatarItem(
          size: widget.avatarSize,
          status: widget.status,
        ),
        Container(
          width: widget.avatarSize,
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            widget.userFullName,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.blackS14W600,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
