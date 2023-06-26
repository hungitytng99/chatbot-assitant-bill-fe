import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/models/entities/conversation_message_entity.dart';

class ChatItemText extends StatefulWidget {
  ConversationMessageEntity conversationMessage;
  ChatItemText({
    required this.conversationMessage,
    Key? key,
  }) : super(key: key);
  @override
  _ChatItemTextState createState() => _ChatItemTextState();
}

class _ChatItemTextState extends State<ChatItemText> {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          constraints: BoxConstraints(
            minWidth: 0,
            maxWidth: MediaQuery.of(context).size.width * 2 / 3,
          ),
          decoration: const BoxDecoration(
            color: AppColors.backgroundGray,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(14),
              bottomRight: Radius.circular(14),
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
          ),
          margin: const EdgeInsets.only(
            top: 4,
            right: 15,
          ),
          child: Text(widget.conversationMessage.content ?? ""),
        ),
      ],
    );
  }
}
