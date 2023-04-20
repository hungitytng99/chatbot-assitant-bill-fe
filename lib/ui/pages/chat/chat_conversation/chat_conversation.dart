import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/entities/chat_content_entity.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatConversation extends StatefulWidget {
  ChatConversation({
    Key? key,
  }) : super(key: key);
  @override
  _ChatConversationState createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> {
  static const _pageSize = 20;
  final PagingController<int, ChatContentEntity> _pagingController =
      PagingController(firstPageKey: 0);

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
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: const Text('Tôi là tôi thấy 1 + 1 = 3 đấy'),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                UserAvatarItem(
                  size: 20,
                  status: UserOnlineStatusEnum.OFFLINE,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      decoration: const BoxDecoration(
                        color: AppColors.grayLighter,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      margin: const EdgeInsets.only(
                        left: 8,
                        top: 4,
                      ),
                      child: const Text(
                          'Tôi năm nay hơn 70 tuổi rồi mà chưa gặp trường hợp nào như thế này'),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.grayLighter,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      margin: const EdgeInsets.only(
                        left: 8,
                        top: 4,
                      ),
                      child: const Text('Ngu'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
