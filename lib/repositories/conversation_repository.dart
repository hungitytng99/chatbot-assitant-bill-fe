import 'package:ihz_bql/models/entities/conversation_history_entity.dart';
import 'package:ihz_bql/models/entities/conversation_response_entity.dart';
import 'package:ihz_bql/networks/api_client.dart';

abstract class ConversationsRepository {
  Future<ConversationHistoryEntity> getConversationHistories(
      {int? page, int? limit});

  Future<ConversationResponseEntity> getMessagesOfConversation({
    required String id,
    int? page,
    int? limit,
  });
}

class ConversationsRepositoryImpl extends ConversationsRepository {
  late ApiClient _apiClient;

  ConversationsRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }
  @override
  Future<ConversationHistoryEntity> getConversationHistories(
      {int? page, int? limit}) {
    return _apiClient.getConversationHistories(page, limit);
  }

  @override
  Future<ConversationResponseEntity> getMessagesOfConversation({
    required String id,
    int? page,
    int? limit,
  }) {
    return _apiClient.getMessagesOfConversation(id, page, limit);
  }
}
