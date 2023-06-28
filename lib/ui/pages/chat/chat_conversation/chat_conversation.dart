import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/conversation_message_entity.dart';
import 'package:ihz_bql/models/enums/chat_actor_type.dart';
import 'package:ihz_bql/models/enums/chat_event_type.dart';
import 'package:ihz_bql/models/enums/conversation_status.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/components/chat_item_text.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatConversation extends StatefulWidget {
  final PagingController<int, ConversationMessageEntity> pagingController;
  final ConversationHistoryItemArgument? conversationHistoryItemArg;
  const ChatConversation({
    Key? key,
    required this.pagingController,
    this.conversationHistoryItemArg,
  }) : super(key: key);
  @override
  _ChatConversationState createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> {
  late ChatDetailCubit _chatDetailCubit;
  @override
  void initState() {
    super.initState();
    _chatDetailCubit = BlocProvider.of<ChatDetailCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getMessageFromConversationStatus(
      ConversationStatus? conversationStatus) {
    if(conversationStatus == ConversationStatus.initial) {
      return Column(
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
      );
    }
    return Container();
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
              chatContent.content != "") {
            return _buildOwnerMessage(
              conversationMessage: chatContent,
            );
          }
          if (chatContent.actor == ChatActorType.bot.getActor &&
              chatContent.content != "") {
            return _buildPartnerMessage(
              conversationMessage: chatContent,
            );
          }
          if (chatContent.actor == ChatActorType.system.getActor &&
              chatContent.content != "") {
            return _buildPartnerMessage(
              conversationMessage: chatContent,
            );
          }
          return Container();
        },
        noItemsFoundIndicatorBuilder: (_) => getMessageFromConversationStatus(
          _chatDetailCubit.state.conversationStatus,
        ),
      ),
    );
  }

  Widget _buildSelectMessage({
    String? question = "",
    List<String>? answers = const [],
    void Function(String?)? onSelectAnswer,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: MediaQuery.of(context).size.width * 2 / 3,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundGray,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question ?? "",
          ),
          for (int i = 0; i < (answers ?? []).length; i++) ...[
            InkWell(
              onTap: () => onSelectAnswer!(answers![i]),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.primaryLighter),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  answers?[i] ?? "",
                  style: AppTextStyle.primaryS14Regular,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
          ],
        ],
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
            const SizedBox(
              width: 10,
            ),
            if (conversationMessage.type == ChatEventType.select.getString) ...[
              _buildSelectMessage(
                question: conversationMessage.question,
                answers: conversationMessage.answers,
                onSelectAnswer: (answer) {
                  // Cập nhật giao diện
                  if (_chatDetailCubit.state.conversationStatus !=
                      ConversationStatus.ended) {
                    widget.pagingController.itemList = [
                      ConversationMessageEntity(
                        id: answer ?? "",
                        type: ChatEventType.text.getString,
                        actor: ChatActorType.user.getActor,
                        content: answer,
                      ),
                      ...?widget.pagingController.itemList,
                    ];
                    _chatDetailCubit.addConversationObjectives(
                      objective: answer ?? "",
                    );
                    // Emit sự kiện
                    _chatDetailCubit.sendClientMessage(message: answer ?? "");
                  }
                },
              )
            ],
            if (conversationMessage.type == ChatEventType.text.getString) ...[
              ChatItemText(conversationMessage: conversationMessage),
            ],
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
