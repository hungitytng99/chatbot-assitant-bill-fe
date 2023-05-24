import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/entities/chat_content_refactor_entity.dart';
import 'package:ihz_bql/models/enums/chat_content_type.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/chat/chat_conversation/chat_conversation.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_horizontal.dart';
import 'package:ihz_bql/ui/pages/homepage/home_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({
    Key? key,
  }) : super(key: key);
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  static const _pageSize = 20;
  final _chatController = TextEditingController(text: '');
  late final ChatDetailCubit _chatDetailCubit;
  final PagingController<int, ChatContentRefactorEntity> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _chatDetailCubit = BlocProvider.of<ChatDetailCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<ChatContentRefactorEntity> chatConversation =
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
            ),
          ),
          _buildChatType(),
        ],
      ),
    );
  }

  Widget _buildChatType() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 8),
      child: TextField(
        controller: _chatController,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Bạn muốn hỏi gì nào...',
            suffixIcon: InkWell(
              onTap: () {
                if (_chatController.text.isNotEmpty) {
                  _pagingController.itemList = [
                    ChatContentRefactorEntity(
                      id: -1,
                      chatContent: [_chatController.text],
                      isOwner: true,
                      type: ChatContentType.text.getType,
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
            userFullName: 'Vũ Ngọc Nam',
            description: 'Đang hoạt động',
            avatarLink: 'https://picsum.photos/200/200',
            avatarSize: 41,
            onPressed: () {},
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
