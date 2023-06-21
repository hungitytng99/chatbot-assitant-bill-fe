import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/conversation_history_item_entity.dart';
import 'package:ihz_bql/models/entities/conversation_message_entity.dart';
import 'package:ihz_bql/models/enums/chat_content_type.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/chat/chat_conversation/chat_conversation.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_horizontal.dart';
import 'package:ihz_bql/ui/pages/homepage/home_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:web_socket_channel/io.dart';

class ChatDetailPage extends StatefulWidget {
  final ConversationHistoryItemArgument? conversationHistoryItemArg;
  const ChatDetailPage({
    Key? key,
    required this.conversationHistoryItemArg,
  }) : super(key: key);
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  static const _pageSize = 20;
  final _chatController = TextEditingController(text: '');
  late final ChatDetailCubit _chatDetailCubit;
  final PagingController<int, ConversationMessageEntity> _pagingController =
      PagingController(firstPageKey: 0);

  late IOWebSocketChannel channel;
  String message = "";

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    channel = IOWebSocketChannel.connect(
        'ws://35.185.176.26:8088/conversations/1048d413-3172-4c57-879f-f0d9c22600e2/interact/d9cd424f-c64c-45f2-9589-abc6ebfb76bf');
    channel.stream.listen((event) {
      handleSocketResponseEvent(jsonDecode(event));
    });
    _chatDetailCubit = BlocProvider.of<ChatDetailCubit>(context);
  }

  String currentReply = "";
  void handleSocketResponseEvent(event) {
    if (event['event'] == 'message_streaming') {
      // if (currentReply.isEmpty) {
      currentReply = currentReply += event['token'] ?? "";
      _pagingController.itemList
          ?.removeWhere((element) => element.id == event['message_id']);
      // _pagingController.itemList = [
      //   ConversationMessageEntity(
      //     id: event['message_id'],
      //     chatContent: [currentReply],
      //     isOwner: true,
      //     type: ChatActorType.text.getType,
      //   ),
      //   ...?_pagingController.itemList,
      // ];
      // } else {
      //   _pagingController.itemList.;
      // }
    }

    if (event['event'] == 'message_stream_end') {
      currentReply = "";
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<ConversationMessageEntity> chatConversation =
          await _chatDetailCubit.getChatConversation(pageKey);
      final bool isLastPage = chatConversation.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(chatConversation);
      } else {
        final int nextPageKey = pageKey + chatConversation.length;
        _pagingController.appendPage(chatConversation, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.primaryLighter,
        backgroundColor: AppColors.primaryLighter,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: AppColors.topContent,
            height: 1.0,
          ),
          preferredSize: const Size.fromHeight(1.0),
        ),
        title: _buildAppBar(context),
      ),
      body: SafeArea(
        child: Container(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ChatConversation(
              pagingController: _pagingController,
              conversationHistoryItemArg: widget.conversationHistoryItemArg,
            ),
          ),
          Visibility(
            visible: widget.conversationHistoryItemArg?.isDisabledChat ?? false,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Text(
                'Đoạn hội thoại này đã kết thúc',
                style: AppTextStyle.blackS14W500,
              ),
            ),
          ),
          Visibility(
            visible:
                !(widget.conversationHistoryItemArg?.isDisabledChat ?? false),
            child: _buildChatType(),
          ),
        ],
      ),
    );
  }

  Widget _buildChatType() {
    // return Column(
    //   children: [
    //     StreamBuilder(
    //       stream: channel.stream,
    //       builder: (context, snapshot) {
    //         return Text(snapshot.hasData ? '${snapshot.data}' : '');
    //       },
    //     ),
    //   ],
    // );
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 8),
      child: TextField(
        controller: _chatController,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Bạn muốn hỏi gì nào...',
            suffixIcon: InkWell(
              onTap: () {
                channel.sink.add(jsonEncode({"message": '123'}));
                if (_chatController.text.isNotEmpty) {
                  // _pagingController.itemList = [
                  //   ConversationMessageEntity(
                  //     id: "-1",
                  //     chatContent: [_chatController.text],
                  //     isOwner: false,
                  //     type: ChatActorType.text.getType,
                  //   ),
                  //   ...?_pagingController.itemList,
                  // ];
                  _chatController.text = '';
                }
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 20.0),
                child: Image.asset(
                  AppImages.icSend,
                  color: AppColors.primary,
                  fit: BoxFit.contain,
                  width: 6,
                  height: 6,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primary,
              ), //<-- SEE HERE
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            )),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(
              top: 8,
              right: 8,
            ),
            child: Image.asset(
              AppImages.icBack,
              color: AppColors.primary,
              height: 18,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: UserAvatarCardHorizontal(
            userFullName:
                widget.conversationHistoryItemArg?.conversationHistory?.title ??
                    "",
            description:
                '${widget.conversationHistoryItemArg?.conversationHistory?.expert?.name ?? ""} • Đang hoạt động',
            avatarLink: widget.conversationHistoryItemArg?.conversationHistory
                    ?.expert?.avatarLink ??
                "",
            avatarSize: 41,
            onPressed: () {},
            width: MediaQuery.of(context).size.width - 145,
          ),
        ),
        InkWell(
          onTap: () {
            Application.router.navigateTo(
              context,
              Routes.home,
              clearStack: true,
              transition: TransitionType.inFromLeft,
              routeSettings: RouteSettings(
                arguments: HomePageArgument(
                  pageIndex: 2,
                ),
              ),
            );
          },
          child: SizedBox(
            width: 30,
            height: 30,
            child: Image.asset(
              AppImages.icDoExercise,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
