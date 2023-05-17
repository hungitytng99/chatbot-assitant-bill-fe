import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/models/entities/chat_content_refactor_entity.dart';

class ChatItemQuestion extends StatefulWidget {
  ChatContentRefactorEntity content;
  ChatItemQuestion({
    Key? key,
    required this.content,
  }) : super(key: key);
  @override
  _ChatItemQuestionState createState() => _ChatItemQuestionState();
}

class _ChatItemQuestionState extends State<ChatItemQuestion> {
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
    return const Text("Chat item question");
  }
}
