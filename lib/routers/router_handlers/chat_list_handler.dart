import 'package:fluro/fluro.dart';
import 'package:ihz_bql/repositories/conversation_repository.dart';
import 'package:ihz_bql/repositories/expert_repository.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler chatListHandler = Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      ExpertRepository expertRepository =
          RepositoryProvider.of<ExpertRepository>(context);
      ConversationsRepository conversationsRepository =
          RepositoryProvider.of<ConversationsRepository>(context);
      return ChatListCubit(
          expertRepository: expertRepository,
          conversationsRepository: conversationsRepository);
    },
    child: const ChatListPage(),
  );
});
