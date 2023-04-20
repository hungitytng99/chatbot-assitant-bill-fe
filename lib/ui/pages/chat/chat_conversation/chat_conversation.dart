import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/entities/chat_content_entity.dart';
import 'package:ihz_bql/models/enums/user_online_status.dart';
import 'package:ihz_bql/ui/pages/common/user_avatar/user_avatar_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatConversation extends StatefulWidget {
  const ChatConversation({
    Key? key,
  }) : super(key: key);
  @override
  _ChatConversationState createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> {
  static const _pageSize = 20;
  final PagingController<int, ChatContentEntity> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  // Test
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  Future<void> _fetchPage(int pageKey) async {
    print(pageKey);
    try {
      await Future.delayed(const Duration(milliseconds: 10000));
      final newItems = [
        for (int i = 0; i < 20; i++) ...[
          ChatContentEntity(
            id: Random().nextInt(1000),
            chatContent: "${getRandomString(10)} $i",
            isOwner: i % 3 == 1,
          )
        ]
      ];
      final bool isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
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
    return PagedListView<int, ChatContentEntity>(
      pagingController: _pagingController,
      reverse: true,
      builderDelegate: PagedChildBuilderDelegate<ChatContentEntity>(
        newPageProgressIndicatorBuilder: (context) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              height: 14.0,
              width: 14.0,
            ),
          ],
        ),
        itemBuilder: (context, chatContent, index) {
          if (chatContent.isOwner) {
            return _buildOwnerMessage(chatContent: chatContent);
          }
          return _buildPartnerMessage(chatContent: chatContent);
        },
      ),
    );
  }

  Widget _buildOwnerMessage({required ChatContentEntity chatContent}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Text(chatContent.chatContent),
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
    );
  }

  Widget _buildPartnerMessage({required ChatContentEntity chatContent}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UserAvatarItem(
              size: 20,
              status: UserOnlineStatusEnum.OFFLINE,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text(chatContent.chatContent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
