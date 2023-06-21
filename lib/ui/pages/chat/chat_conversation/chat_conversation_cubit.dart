import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/repositories/conversation_repository.dart';
part 'chat_conversation_state.dart';

class ChatConversationCubit extends Cubit<ChatConversationState> {
  ConversationsRepository conversationsRepository;
  ChatConversationCubit({
    required this.conversationsRepository,
  }) : super(const ChatConversationState());
}
