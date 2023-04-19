import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_horizontal.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_card_vertical.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({
    Key? key,
  }) : super(key: key);
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
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
                              child: Row(
                                children: <Widget>[
                                  for (int i = 0; i < 10; i++) ...{
                                    Container(
                                      padding: const EdgeInsets.only(
                                        top: 6,
                                        left: 12,
                                        bottom: 8,
                                        right: 12,
                                      ),
                                      child: UserAvatarCardVertical(
                                        userFullName: 'Trần Mạnh Hùng',
                                        onPressed: () {
                                          Application.router.navigateTo(
                                            context,
                                            Routes.chatConversation,
                                            rootNavigator: true,
                                          );
                                        },
                                      ),
                                    ),
                                  }
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (int i = 0; i < 10; i++) ...{
                        Container(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: UserAvatarCardHorizontal(
                            userFullName: 'Trần Mạnh Hùng',
                            time: "12:39",
                            onPressed: () {
                              Application.router.navigateTo(
                                context,
                                Routes.chatConversation,
                                rootNavigator: true,
                              );
                            },
                          ),
                        ),
                      }
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
