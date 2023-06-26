import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/conversation_message_entity.dart';
import 'package:ihz_bql/models/entities/socket/base_socket_response_entity.dart';
import 'package:ihz_bql/models/entities/socket/socket_select_entity.dart';
import 'package:ihz_bql/models/entities/socket/socket_text_entity.dart';
import 'package:ihz_bql/models/enums/chat_actor_type.dart';
import 'package:ihz_bql/models/enums/chat_event_name.dart';
import 'package:ihz_bql/models/enums/chat_event_type.dart';
import 'package:ihz_bql/models/enums/conversation_status.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/params/create_conversation_body.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/chat/chat_conversation/chat_conversation.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_horizontal.dart';
import 'package:ihz_bql/ui/pages/homepage/home_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:web_socket_channel/io.dart';
import 'package:uuid/uuid.dart';

class ChatDetailPage extends StatefulWidget {
  final ConversationHistoryItemArgument? conversationHistoryItemArg;
  const ChatDetailPage({
    Key? key,
    this.conversationHistoryItemArg,
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
  IOWebSocketChannel? channel;
  String message = "";

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _chatDetailCubit = BlocProvider.of<ChatDetailCubit>(context);
    _chatDetailCubit.createNewConversations(
      body: CreateConversationBody(
          expertId: widget.conversationHistoryItemArg?.expertEntity?.id ?? ""),
    );
  }

  String currentReply = "";
  void handleSocketResponseEvent(event) {
    print("✅ [SOCKET] Event: ${event}");
    final BaseSocketResponseEntity socketEvent =
        BaseSocketResponseEntity.fromJson(event);
    if (socketEvent.event == ChatEventsName.topicInit.getString &&
        socketEvent.type == ChatEventType.select.getString) {
      final SocketSelectEntity socketContent =
          SocketSelectEntity.fromJson(event);
      _pagingController.itemList = [
        ConversationMessageEntity(
          id: socketEvent.messageId ?? "",
          type: socketEvent.type ?? "",
          actor: ChatActorType.bot.getActor,
          question: socketContent.question,
          answers: socketContent.answers,
        ),
        ...?_pagingController.itemList,
      ];
    }

    if (socketEvent.event == ChatEventsName.messageStreaming.getString) {
      _chatDetailCubit.changeConversationStatusState(
        conversationStatus: ConversationStatus.ready,
      );
      final SocketTextEntity socketContent = SocketTextEntity.fromJson(event);
      currentReply += socketContent.message;
      _pagingController.itemList?.removeWhere(
        (element) => element.id == socketEvent.messageId,
      );
      _pagingController.itemList = [
        ConversationMessageEntity(
          id: socketEvent.messageId ?? "",
          actor: ChatActorType.bot.getActor,
          content: currentReply,
          type: socketEvent.type ?? "",
        ),
        ...?_pagingController.itemList,
      ];
    }

    if (socketEvent.event == ChatEventsName.messageStreamEnd.getString) {
      _chatDetailCubit.changeConversationStatusState(
        conversationStatus: ConversationStatus.ready,
      );
      currentReply = "";
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<ConversationMessageEntity> chatConversation =
          await _chatDetailCubit.getChatConversation(
              pageKey, widget.conversationHistoryItemArg?.conversationId ?? "");
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
            child: BlocListener<ChatDetailCubit, ChatDetailState>(
              listener: (context, state) {
                if (state.createConversationStatus == LoadStatus.success) {
                  print(
                      '✅ [SOCKET] Connect to ${state.createConversationEntity?.socketPath ?? ""}');
                  channel = IOWebSocketChannel.connect(
                    state.createConversationEntity?.socketPath ?? "",
                  );
                  _chatDetailCubit.changeSocketChannel(socketChannel: channel);
                  channel?.stream.listen(
                    (event) {
                      try {
                        handleSocketResponseEvent(
                          jsonDecode(event.replaceAll("'", '"')),
                        );
                      } catch (e) {
                        print("✅ [SOCKET] Event: ${event}");
                        print("[SOCKET_ERROR]: $e");
                      }
                    },
                    onError: (event) {
                      _chatDetailCubit.changeConversationStatusState(
                        conversationStatus: ConversationStatus.error,
                      );
                    },
                  );
                  setState(() {
                    _chatDetailCubit.changeConversationStatusState(
                      conversationStatus: ConversationStatus.ready,
                    );
                  });
                }
              },
              listenWhen: (prev, current) {
                return prev.createConversationStatus !=
                    current.createConversationStatus;
              },
              child: ChatConversation(
                pagingController: _pagingController,
                conversationHistoryItemArg: widget.conversationHistoryItemArg,
              ),
            ),
          ),
          Visibility(
            visible: _chatDetailCubit.state.conversationStatus ==
                ConversationStatus.ended,
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
            visible: !(_chatDetailCubit.state.conversationStatus ==
                ConversationStatus.ended),
            child: _buildChatType(),
          ),
        ],
      ),
    );
  }

  String getHintTextChat(ConversationStatus? conversationStatus) {
    switch (conversationStatus) {
      case ConversationStatus.initial:
        return "Đang khởi tạo kết nối...";
      case ConversationStatus.request:
        return "Đang nghĩ...";
      case ConversationStatus.ready:
        return "Bạn muốn hỏi gì nào...";
      case ConversationStatus.ended:
        return "Cuộc hội thoại đã kết thúc";
      case ConversationStatus.error:
        return "Một lỗi đã xáy ra!";
      default:
        return "Bạn muốn hỏi gì nào...";
    }
  }

  Widget _buildChatType() {
    return BlocBuilder<ChatDetailCubit, ChatDetailState>(
      buildWhen: (prev, current) =>
          prev.conversationStatus != current.conversationStatus,
      builder: (context, state) {
        return Container(
          margin:
              const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 8),
          child: TextField(
            enabled: _chatDetailCubit.state.conversationStatus ==
                    ConversationStatus.ready &&
                _chatDetailCubit.state.conversationStatus !=
                    ConversationStatus.request,
            controller: _chatController,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText:
                    getHintTextChat(_chatDetailCubit.state.conversationStatus),
                suffixIcon: InkWell(
                  onTap: () {
                    if (_chatController.text.isNotEmpty) {
                      _chatDetailCubit.sendClientMessage(
                        message: _chatController.text,
                      );
                      const uuid = Uuid();
                      _pagingController.itemList = [
                        ConversationMessageEntity(
                          id: uuid.v4(),
                          actor: ChatActorType.user.getActor,
                          content: _chatController.text,
                          type: ChatEventType.text.getString,
                        ),
                        ...?_pagingController.itemList,
                      ];
                      _chatController.text = '';
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 20.0),
                    child: Image.asset(
                      AppImages.icSend,
                      color: _chatDetailCubit.state.conversationStatus ==
                              ConversationStatus.ready
                          ? AppColors.primary
                          : AppColors.grey,
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
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.grey,
                  ), //<-- SEE HERE
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                )),
          ),
        );
      },
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
                widget.conversationHistoryItemArg?.conversationTitle ??
                    "Đoạn hội thoại mới",
            description:
                '${widget.conversationHistoryItemArg?.expertEntity?.name ?? ""} • Đang hoạt động',
            avatarLink:
                widget.conversationHistoryItemArg?.expertEntity?.avatarLink ??
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
