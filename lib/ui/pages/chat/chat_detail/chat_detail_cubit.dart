import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/conversation_message_entity.dart';
import 'package:ihz_bql/models/entities/conversation_response_entity.dart';
import 'package:ihz_bql/models/entities/create_conversation_entity.dart';
import 'package:ihz_bql/models/entities/socket/user_send_message_entity.dart';
import 'package:ihz_bql/models/enums/chat_event_name.dart';
import 'package:ihz_bql/models/enums/conversation_status.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/params/create_conversation_body.dart';
import 'package:ihz_bql/repositories/conversation_repository.dart';
import 'package:web_socket_channel/io.dart';
part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ConversationsRepository conversationsRepository;
  ChatDetailCubit({
    required this.conversationsRepository,
  }) : super(ChatDetailState());

  Future<void> createNewConversations({
    CreateConversationBody? body,
  }) async {
    emit(state.copyWith(createConversationStatus: LoadStatus.loading));
    try {
      final CreateConversationEntity result =
          await conversationsRepository.createNewConversations(body: body);

      emit(state.copyWith(
        createConversationStatus: LoadStatus.success,
        createConversationEntity: result,
      ));
    } catch (e) {
      emit(state.copyWith(createConversationStatus: LoadStatus.failure));
    }
  }

  Future<List<ConversationMessageEntity>> getChatConversation(
    int pageKey,
    String conversationId,
  ) async {
    try {
      final ConversationResponseEntity result =
          await conversationsRepository.getMessagesOfConversation(
        id: conversationId,
      );
      return result.conversation.messages ?? [];
    } catch (e) {
      return [];
    }
  }

  void sendClientMessage({
    String message = "",
  }) {
    changeConversationStatusState(
      conversationStatus: ConversationStatus.request,
    );
    final messageEvent = UserSendMessageEntity(
      event: ChatEventsName.clientMessage.getString,
      message: message,
      objectives: state.currentObjectives,
    ).toJson();
    state.socketChannel?.sink.add(
      jsonEncode(messageEvent),
    );
    print("✅ [SOCKET_EMIT] Event: $messageEvent");
  }

  void changeConversationStatusState({
    required ConversationStatus conversationStatus,
  }) {
    emit(
      state.copyWith(conversationStatus: conversationStatus),
    );
  }

  void changeConversationTitle({
    String? conversationTitle,
  }) {
    emit(
      state.copyWith(conversationTitle: conversationTitle),
    );
  }

  void changeSocketChannel({
    required IOWebSocketChannel? socketChannel,
  }) {
    emit(
      state.copyWith(socketChannel: socketChannel),
    );
  }

  void addConversationObjectives({
    required String objective,
  }) {
    if ((state.currentObjectives ?? []).length < 2) {
      emit(
        state.copyWith(
            currentObjectives: [...(state.currentObjectives ?? []), objective]),
      );
      return;
    }
    state.currentObjectives?.removeAt(0);
    emit(
      state.copyWith(currentObjectives: [
        objective,
        ...(state.currentObjectives ?? []),
      ]),
    );
  }

  void removeConversationObjectives({
    required String objective,
  }) {
    final newLists = (state.currentObjectives ?? [])
      ..removeWhere((item) => item == objective);
    emit(
      state.copyWith(currentObjectives: newLists),
    );
  }

  void removeAllConversationObjectives() {
    emit(
      state.copyWith(currentObjectives: []),
    );
  }
}
