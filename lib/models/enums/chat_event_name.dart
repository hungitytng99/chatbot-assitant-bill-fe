enum ChatEventsName {
  topicInit,
  clientMessage,
  conversationTitle,
  messageStreaming,
  messageStreamEnd,
  conversationEnd,
  messageStreamError,
  connectionError,
  topicRecommendation,
  clientEndConversation,
}

extension ChatEventsNameExtension on ChatEventsName {
  String get getString {
    switch (this) {
      case ChatEventsName.topicInit:
        return 'topic_init';
      case ChatEventsName.clientMessage:
        return 'client_message';
      case ChatEventsName.conversationTitle:
        return 'conversation_title';
      case ChatEventsName.messageStreaming:
        return 'message_streaming';
      case ChatEventsName.messageStreamEnd:
        return 'message_stream_end';
      case ChatEventsName.conversationEnd:
        return 'conversation_end';
      case ChatEventsName.messageStreamError:
        return 'message_stream_error';
      case ChatEventsName.topicRecommendation:
        return 'topic_recommendation';
      case ChatEventsName.connectionError:
        return 'connection_error';
      case ChatEventsName.clientEndConversation:
        return 'client_end_conversation';
    }
  }
}
