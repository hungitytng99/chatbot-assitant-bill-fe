import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/conversation_history_entity.dart';
import 'package:ihz_bql/models/entities/conversation_history_item_entity.dart';
import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/models/enums/conversation_status.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_cubit.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_horizontal.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_vertical.dart';
import 'package:ihz_bql/utils/date_utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({
    Key? key,
  }) : super(key: key);
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late ChatListCubit _chatListCubit;
  final PagingController<int, ConversationHistoryItemEntity> _pagingController =
      PagingController(firstPageKey: 1);
  late ChatDetailCubit _chatDetailCubit;
  @override
  void initState() {
    super.initState();
    _chatListCubit = BlocProvider.of<ChatListCubit>(context);
    _chatListCubit.getActiveExpert();
    _chatDetailCubit = BlocProvider.of<ChatDetailCubit>(context);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<ConversationHistoryItemEntity> chatConversation =
          await _chatListCubit.getListConversationHistories(
        page: pageKey,
        limit: 10,
      );
      final bool isLastPage = chatConversation.length < 10;
      if (isLastPage) {
        _pagingController.appendLastPage(chatConversation);
      } else {
        int nextPageKey = pageKey + 1;
        _pagingController.appendPage(chatConversation, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.backgroundGray,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 2, top: 5),
                            child: Text(
                              "Các chuyên gia",
                              textAlign: TextAlign.start,
                              style: AppTextStyle.greyS14W600,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const ClampingScrollPhysics(),
                            child: BlocBuilder<ChatListCubit, ChatListState>(
                              bloc: _chatListCubit,
                              buildWhen: (prev, current) {
                                return (prev.getActiveExpertsStatus !=
                                    current.getActiveExpertsStatus);
                              },
                              builder: (context, state) {
                                return Row(
                                  children: <Widget>[
                                    for (int i = 0;
                                        i <
                                            _chatListCubit
                                                .state.activeExperts.length;
                                        i++) ...{
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 6,
                                          left: 12,
                                          bottom: 8,
                                          right: 12,
                                        ),
                                        child: UserAvatarCardVertical(
                                          userFullName: _chatListCubit
                                              .state.activeExperts[i].name,
                                          avatarLink: _chatListCubit.state
                                              .activeExperts[i].avatarLink,
                                          onPressed: () {
                                            Application.router.navigateTo(
                                              context,
                                              Routes.chatDetail,
                                              rootNavigator: true,
                                              routeSettings: RouteSettings(
                                                arguments:
                                                    ConversationHistoryItemArgument(
                                                  expertEntity: _chatListCubit
                                                      .state.activeExperts[i],
                                                  conversationId: "",
                                                  conversationTitle:
                                                      "Đoạn hội thoại mới",
                                                  isCreateNewConversation: true,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    }
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 280,
                      child: PagedListView<int, ConversationHistoryItemEntity>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<
                            ConversationHistoryItemEntity>(
                          newPageProgressIndicatorBuilder: (context) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 6),
                                height: 14.0,
                                width: 14.0,
                              ),
                            ],
                          ),
                          itemBuilder: (context, conversationHistory, index) {
                            return Container(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: UserAvatarCardHorizontal(
                                userFullName: conversationHistory.title ?? "",
                                description:
                                    "${conversationHistory.expert?.name} • ${conversationHistory.lastMessage}",
                                avatarLink:
                                    conversationHistory.expert?.avatarLink ??
                                        "",
                                time: AppDateUtils.toDateDisplayString(
                                  conversationHistory.updatedAt,
                                  format: "HH:mm",
                                ),
                                width: MediaQuery.of(context).size.width - 125,
                                onPressed: () {
                                  _chatDetailCubit
                                      .changeConversationStatusState(
                                    conversationStatus:
                                    ConversationStatus.ended,
                                  );
                                  Application.router.navigateTo(
                                    context,
                                    Routes.chatDetail,
                                    rootNavigator: true,
                                    routeSettings: RouteSettings(
                                      arguments:
                                          ConversationHistoryItemArgument(
                                        expertEntity:
                                            conversationHistory.expert,
                                        conversationId: conversationHistory.id,
                                        conversationTitle:
                                            conversationHistory.title,
                                        conversationStatus:
                                            ConversationStatus.ended,
                                        isCreateNewConversation: false,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          noItemsFoundIndicatorBuilder: (_) => Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: const Center(
                              child: Text(
                                  'Hãy chọn 1 chuyên gia để bắt đầu trò chuyện ngay nào'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationHistoryItemArgument {
  ExpertEntity? expertEntity;
  String? conversationId;
  String? conversationTitle;
  ConversationStatus conversationStatus;
  bool isCreateNewConversation;
  ConversationHistoryItemArgument({
    required this.expertEntity,
    required this.conversationId,
    required this.conversationTitle,
    this.isCreateNewConversation = false,
    this.conversationStatus = ConversationStatus.ended,
  });
}
