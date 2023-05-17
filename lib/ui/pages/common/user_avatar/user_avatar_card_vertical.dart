import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';

class UserAvatarCardVertical extends StatefulWidget {
  double avatarSize;
  UserOnlineStatusEnum status;
  String userFullName;
  VoidCallback onPressed;

  UserAvatarCardVertical({
    required this.userFullName,
    required this.onPressed,
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
    return InkWell(
      onTap: widget.onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserAvatarItem(
            avatarLink: 'https://picsum.photos/200/200',
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
      ),
    );
  }
}
