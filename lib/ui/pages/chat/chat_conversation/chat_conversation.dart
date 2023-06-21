import 'package:flutter/material.dart';
import 'package:ihz_bql/models/entities/conversation_message_entity.dart';
import 'package:ihz_bql/models/enums/chat_content_type.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/components/chat_item_text.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatConversation extends StatefulWidget {
  PagingController<int, ConversationMessageEntity> pagingController;
  final ConversationHistoryItemArgument? conversationHistoryItemArg;

  ChatConversation({
    Key? key,
    required this.pagingController,
    this.conversationHistoryItemArg,
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
    return PagedListView<int, ConversationMessageEntity>(
      pagingController: widget.pagingController,
      reverse: true,
      builderDelegate: PagedChildBuilderDelegate<ConversationMessageEntity>(
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
          if (chatContent.actor == ChatActorType.user.getActor &&
              chatContent.content!.isNotEmpty) {
            return _buildOwnerMessage(
              conversationMessage: chatContent,
            );
          }
          if (chatContent.actor == ChatActorType.bot.getActor &&
              chatContent.content!.isNotEmpty) {
            return _buildPartnerMessage(
              conversationMessage: chatContent,
            );
          }
          if (chatContent.actor == ChatActorType.system.getActor &&
              chatContent.content!.isNotEmpty) {
            return _buildPartnerMessage(
              conversationMessage: chatContent,
            );
          }
          return Container();
        },
        noItemsFoundIndicatorBuilder: (_) => Column(
          children: const [
            SizedBox(
              height: 22,
            ),
            CircularProgressIndicator(),
            SizedBox(
              height: 14,
            ),
            Text('Đang khởi tạo kết nối...')
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerMessage(
      {required ConversationMessageEntity conversationMessage}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        margin: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UserAvatarItem(
              avatarLink:
                  widget.conversationHistoryItemArg?.expertEntity?.avatarLink ??
                      "",
              size: 20,
              status: UserOnlineStatusEnum.OFFLINE,
            ),
            ChatItemText(conversationMessage: conversationMessage),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerMessage({
    required ConversationMessageEntity conversationMessage,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        margin: const EdgeInsets.only(left: 10),
        child: ChatItemText(conversationMessage: conversationMessage),
      ),
    );
  }
}
