import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/repositories/conversation_repository.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_page.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';

Handler chatDetailHandler = Handler(handlerFunc: (context, parameters) {
  ConversationHistoryItemArgument? arg =
      context!.arguments as ConversationHistoryItemArgument?;
  return BlocProvider(
    create: (context) {
      ConversationsRepository conversationsRepository =
          RepositoryProvider.of<ConversationsRepository>(context);
      return ChatDetailCubit(conversationsRepository: conversationsRepository);
    },
    child: ChatDetailPage(
      conversationHistoryItemArg: arg,
    ),
  );
});
