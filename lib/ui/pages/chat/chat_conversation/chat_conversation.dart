import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/models/entities/chat_content_refactor_entity.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatConversation extends StatefulWidget {
  PagingController<int, ChatContentRefactorEntity> pagingController;

  ChatConversation({
    Key? key,
    required this.pagingController,
  }) : super(key: key);
  @override
  _ChatConversationState createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, ChatContentRefactorEntity>(
      pagingController: widget.pagingController,
      reverse: true,
      builderDelegate: PagedChildBuilderDelegate<ChatContentRefactorEntity>(
        newPageProgressIndicatorBuilder: (context) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
              margin: const EdgeInsets.only(top: 10, bottom: 6),
              height: 14.0,
              width: 14.0,
            ),
          ],
        ),
        itemBuilder: (context, chatContent, index) {
          if (chatContent.isOwner) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: _buildOwnerMessage(
                content: chatContent,
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: _buildPartnerMessage(content: chatContent),
          );
        },
      ),
    );
  }

  Widget _buildOwnerMessage({required ChatContentRefactorEntity content}) {
    return Column(
      children: [
        for (int i = 0; i < content.chatContent.length; i++) ...[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              margin: const EdgeInsets.only(
                top: 4,
                right: 10,
              ),
              child: Text(content.chatContent[i]),
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
          )
        ]
      ],
    );
  }

  Widget _buildPartnerMessage({required ChatContentRefactorEntity content}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        margin: const EdgeInsets.only(left: 10),
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
                for (int i = 0; i < content.chatContent.length; i++) ...[
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
                    child: Text(content.chatContent[i]),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
