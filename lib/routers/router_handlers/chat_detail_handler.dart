
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_detail/chat_detail_page.dart';

Handler chatDetailHandler = Handler(handlerFunc: (context, parameters) {
  return BlocProvider(
    create: (context) {
      return ChatDetailCubit();
    },
    child: const ChatDetailPage(),
  );
});
  
