import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/models/entities/chat_content_refactor_entity.dart';

class ChatItemText extends StatefulWidget {
  ChatContentRefactorEntity content;
  ChatItemText({
    required this.content,
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
        for (int i = 0; i < widget.content.chatContent.length; i++) ...[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: const BoxDecoration(
              color: AppColors.grayLighter,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14),
                // ? Radius.circular(14)
                // : Radius.circular(4),
                bottomRight: Radius.circular(14),
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            margin: const EdgeInsets.only(
              left: 8,
              top: 4,
            ),
            child: Text(widget.content.chatContent[i]),
          ),
        ],
      ],
    );
  }
}
