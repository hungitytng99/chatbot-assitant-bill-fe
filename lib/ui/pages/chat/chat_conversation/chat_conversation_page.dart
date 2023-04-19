import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_horizontal.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';

class ChatConversationPage extends StatefulWidget {
  ChatConversationPage({
    Key? key,
  }) : super(key: key);
  @override
  _ChatConversationPageState createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
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
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          margin: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: const Text('DETAIL'),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              UserAvatarItem(
                                size: 20,
                                status: UserOnlineStatusEnum.OFFLINE,
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.grayLighter,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(14),
                                        bottomRight: Radius.circular(14),
                                        topLeft: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 8,
                                      top: 4,
                                    ),
                                    child: const Text('DETAIL'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.grayLighter,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(14),
                                        bottomRight: Radius.circular(14),
                                        topLeft: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 8,
                                      top: 4,
                                    ),
                                    child: const Text('DETAIL'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Bạn muốn hỏi gì nào...',
            suffixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(end: 20.0),
              child: Image.asset(
                AppImages.icSend,
                color: AppColors.primary,
                fit: BoxFit.contain,
                width: 6,
                height: 6,
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
            userFullName: 'Trần Mạnh Hùng',
            description: 'Đang hoạt động',
            avatarSize: 41,
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 30,
          height: 30,
          child: Image.asset(
            AppImages.icDoExercise,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
