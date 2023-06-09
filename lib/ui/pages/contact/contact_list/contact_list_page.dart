import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_horizontal.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/contact/contact_list/contact_list_cubit.dart';
import 'package:ihz_bql/ui/widgets/commons/app_snackbar.dart';
import 'package:ihz_bql/utils/flush_bar_utils.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({
    Key? key,
  }) : super(key: key);
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late ContactListCubit _contactListCubit;
  @override
  void initState() {
    _contactListCubit = BlocProvider.of<ContactListCubit>(context);
    _contactListCubit.getActiveExpert();
    _contactListCubit.getInActiveExpert();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactListCubit, ContactListState>(
      buildWhen: (prev, current) =>
          prev.getActiveExpertsStatus != current.getActiveExpertsStatus ||
          prev.getInActiveExpertsStatus != current.getInActiveExpertsStatus,
      builder: (context, state) {
        if (state.getActiveExpertsStatus == LoadStatus.loading ||
            state.getActiveExpertsStatus == LoadStatus.initial ||
            state.getInActiveExpertsStatus == LoadStatus.loading ||
            state.getInActiveExpertsStatus == LoadStatus.initial) {
          return const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.getActiveExpertsStatus == LoadStatus.success) {
          return _buildBody();
        } else {
          return const Center(
            child: Text("Một lỗi đã xảy ra"),
          );
        }
      },
    );
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
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 2, top: 5),
                        child: Text(
                          "Đang hoạt động",
                          textAlign: TextAlign.start,
                          style: AppTextStyle.greyS14W600,
                        ),
                      ),
                      for (int i = 0;
                          i < _contactListCubit.state.activeExperts.length;
                          i++) ...{
                        Container(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: UserAvatarCardHorizontal(
                            userFullName:
                                _contactListCubit.state.activeExperts[i].name,
                            avatarLink: _contactListCubit
                                .state.activeExperts[i].avatarLink,
                            width: MediaQuery.of(context).size.width - 75,
                            onPressed: () {
                              Application.router.navigateTo(
                                context,
                                Routes.chatDetail,
                                rootNavigator: true,
                                routeSettings: RouteSettings(
                                  arguments: ConversationHistoryItemArgument(
                                    expertEntity: _contactListCubit
                                        .state.activeExperts[i],
                                    conversationId: "",
                                    conversationTitle: "Đoạn hội thoại mới",
                                    isCreateNewConversation: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      },
                      Container(
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 2, top: 5),
                        child: Text(
                          "Không hoạt động",
                          textAlign: TextAlign.start,
                          style: AppTextStyle.greyS14W600,
                        ),
                      ),
                      for (int i = 0;
                          i <
                              (_contactListCubit.state.inActiveExperts
                                          ?.upCommingExperts ??
                                      [])
                                  .length;
                          i++) ...{
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: UserAvatarCardHorizontal(
                              userFullName: _contactListCubit
                                      .state
                                      .inActiveExperts
                                      ?.upCommingExperts[i]
                                      .name ??
                                  "",
                              status: UserOnlineStatusEnum.OFFLINE,
                              width: MediaQuery.of(context).size.width - 85,
                              avatarLink: _contactListCubit
                                      .state
                                      .inActiveExperts
                                      ?.upCommingExperts[i]
                                      .avatarLink ??
                                  "",
                              description: 'Chuyên gia hiện không khả dụng',
                              onPressed: () {
                                AppSnackbar.showError(
                                  title: 'Không khả dụng',
                                  message: 'Chuyên gia này hiện không khả dụng',
                                );
                              },
                            ),
                          ),
                        ),
                      },
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
