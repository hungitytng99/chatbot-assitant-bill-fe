
import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler chatListHandler = Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return ChatListCubit();
    },
    child: const ChatListPage(),
  );
});
  
