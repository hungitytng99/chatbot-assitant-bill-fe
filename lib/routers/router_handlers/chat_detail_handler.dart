import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_page.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';

Handler chatDetailHandler = Handler(handlerFunc: (context, parameters) {
  ConversationHistoryItemArgument? arg =
      context!.arguments as ConversationHistoryItemArgument?;
  return ChatDetailPage(
    conversationHistoryItemArg: arg,
  );
});
