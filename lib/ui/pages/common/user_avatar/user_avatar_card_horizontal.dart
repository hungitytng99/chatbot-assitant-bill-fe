import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';

class UserAvatarCardHorizontal extends StatefulWidget {
  double avatarSize;
  UserOnlineStatusEnum status;
  String userFullName;
  String avatarLink;
  String description;
  VoidCallback onPressed;
  String time;
  double width;

  UserAvatarCardHorizontal({
    required this.userFullName,
    required this.avatarLink,
    required this.onPressed,
    required this.width,
    this.avatarSize = 55,
    this.status = UserOnlineStatusEnum.ONLINE,
    this.description = 'Bắt đầu trò chuyện ngay nào',
    this.time = "",
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
    return InkWell(
      onTap: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: UserAvatarItem(
              avatarLink: widget.avatarLink,
              size: widget.avatarSize,
              status: widget.status,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                width: widget.width,
                child: Text(
                  widget.userFullName.trim(),
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.blackS14W600,
                  maxLines: 1,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: widget.width,
                    ),
                    child: Text(
                      widget.description,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.greyS12W400,
                      maxLines: 1,
                    ),
                  ),
                  Visibility(
                    visible: widget.time != "",
                    child: Text(
                      ' • ${widget.time}',
                      style: AppTextStyle.greyS12W400,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
