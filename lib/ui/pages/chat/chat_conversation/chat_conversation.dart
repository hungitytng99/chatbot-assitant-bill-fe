import 'package:flutter/material.dart';
import 'package:ihz_bql/models/entities/chat_content_refactor_entity.dart';
import 'package:ihz_bql/models/enums/chat_content_type.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/components/chat_item_question.dart';
import 'package:ihz_bql/ui/components/chat_item_text.dart';
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
    if (content.type == ChatContentType.question.getType) {
      return ChatItemQuestion(
        content: content,
      );
    }
    if (content.type == ChatContentType.text.getType) {
      // return ChatItemText(
      //   content: content,
      // );
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
                avatarLink: 'https://picsum.photos/200/200',
                size: 20,
                status: UserOnlineStatusEnum.OFFLINE,
              ),
              ChatItemText(content: content),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildPartnerMessage({required ChatContentRefactorEntity content}) {
    if (content.type == ChatContentType.question.getType) {
      return ChatItemQuestion(
        content: content,
      );
    }
    if (content.type == ChatContentType.text.getType) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          margin: const EdgeInsets.only(left: 10),
          child: ChatItemText(content: content),
        ),
      );
    }
    return Container();
  }
}
