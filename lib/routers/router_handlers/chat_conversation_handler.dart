
import 'package:fluro/fluro.dart';
import 'package:ihz_bql/ui/pages/chat/chat_conversation/chat_conversation_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_conversation/chat_conversation_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler chatConversationHandler = new Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return ChatConversationCubit();
    },
    child: ChatConversationPage(),
  );
});
  
