import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/conversation_history_item_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_cubit.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_horizontal.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_vertical.dart';
import 'package:ihz_bql/utils/date_utils.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({
    Key? key,
  }) : super(key: key);
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late ChatListCubit _chatListCubit;

  @override
  void initState() {
    super.initState();
    _chatListCubit = BlocProvider.of<ChatListCubit>(context);
    _chatListCubit.getActiveExpert();
    _chatListCubit.getListConversationHistories(page: 1, limit: 10);
  }

  @override
  void dispose() {
    super.dispose();
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
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
                      BlocBuilder<ChatListCubit, ChatListState>(
                        bloc: _chatListCubit,
                        buildWhen: (prev, current) {
                          return (prev.getConversationHistoriesStatus !=
                              current.getConversationHistoriesStatus);
                        },
                        builder: (context, state) {
                          if (state.getConversationHistoriesStatus ==
                                  LoadStatus.loading ||
                              state.getConversationHistoriesStatus ==
                                  LoadStatus.initial) {
                            return Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return Column(
                            children: [
                              Visibility(
                                visible: (state.conversationHistoryEntity
                                            ?.conversations ??
                                        [])
                                    .isEmpty,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: const Center(
                                    child: Text(
                                        'Hãy chọn 1 chuyên gia để bắt đầu trò chuyện ngay nào'),
                                  ),
                                ),
                              ),
                              for (int i = 0;
                                  i <
                                      (state.conversationHistoryEntity
                                                  ?.conversations ??
                                              [])
                                          .length;
                                  i++) ...{
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: UserAvatarCardHorizontal(
                                    userFullName: state
                                            .conversationHistoryEntity
                                            ?.conversations[i]
                                            .title ??
                                        "",
                                    description:
                                        "${state.conversationHistoryEntity?.conversations[i].expert?.name} • ${state.conversationHistoryEntity?.conversations[i].lastMessage}",
                                    avatarLink: state
                                            .conversationHistoryEntity
                                            ?.conversations[i]
                                            .expert
                                            ?.avatarLink ??
                                        "",
                                    time: AppDateUtils.toDateDisplayString(
                                        state.conversationHistoryEntity
                                            ?.conversations[i].updatedAt,
                                        format: "HH:mm"),
                                    width:
                                        MediaQuery.of(context).size.width - 125,
                                    onPressed: () {
                                      Application.router.navigateTo(
                                        context,
                                        Routes.chatDetail,
                                        rootNavigator: true,
                                        routeSettings: RouteSettings(
                                          arguments:
                                              ConversationHistoryItemArgument(
                                            conversationHistory: state
                                                .conversationHistoryEntity
                                                ?.conversations[i],
                                            isDisabledChat: true,
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
                    ],
                  ),
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
  ConversationHistoryItemEntity? conversationHistory;
  bool isDisabledChat;
  ConversationHistoryItemArgument({
    required this.conversationHistory,
    this.isDisabledChat = false,
  });
}
