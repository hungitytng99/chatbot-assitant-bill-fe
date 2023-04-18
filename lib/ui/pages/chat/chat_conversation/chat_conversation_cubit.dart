
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'chat_conversation_state.dart';

class ChatConversationCubit extends Cubit<ChatConversationState> {
  ChatConversationCubit() : super(ChatConversationState());
}
  
