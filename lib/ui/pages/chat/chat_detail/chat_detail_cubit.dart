import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/conversation_message_entity.dart';
import 'package:ihz_bql/models/entities/conversation_response_entity.dart';
import 'package:ihz_bql/repositories/conversation_repository.dart';
part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ConversationsRepository conversationsRepository;
  ChatDetailCubit({
    required this.conversationsRepository,
  }) : super(const ChatDetailState());

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
}
