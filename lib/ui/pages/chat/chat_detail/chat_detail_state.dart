part of 'chat_detail_cubit.dart';

class ChatDetailState extends Equatable {
  final LoadStatus? createConversationStatus;
  final CreateConversationEntity? createConversationEntity;
  final List<String>? currentObjectives;
  final List<String>? suggestObjectives;
  final ConversationStatus conversationStatus;
  final String? conversationTitle;
  final IOWebSocketChannel? socketChannel;

  @override
  List<Object?> get props => [
        createConversationEntity,
        createConversationStatus,
        currentObjectives,
        suggestObjectives,
        conversationStatus,
        conversationTitle,
        socketChannel,
      ];

  const ChatDetailState({
    this.createConversationEntity,
    this.createConversationStatus,
    this.currentObjectives,
    this.conversationStatus = ConversationStatus.initial,
    this.conversationTitle,
    this.socketChannel,
    this.suggestObjectives,
  });

  ChatDetailState copyWith({
    LoadStatus? createConversationStatus,
    CreateConversationEntity? createConversationEntity,
    List<String>? currentObjectives,
    ConversationStatus? conversationStatus,
    String? conversationTitle,
    IOWebSocketChannel? socketChannel,
    List<String>? suggestObjectives,
  }) {
    return ChatDetailState(
      createConversationEntity:
          createConversationEntity ?? this.createConversationEntity,
      createConversationStatus:
          createConversationStatus ?? this.createConversationStatus,
      currentObjectives: currentObjectives ?? this.currentObjectives,
      conversationStatus: conversationStatus ?? this.conversationStatus,
      conversationTitle: conversationTitle ?? this.conversationTitle,
      socketChannel: socketChannel ?? this.socketChannel,
      suggestObjectives: suggestObjectives ?? this.suggestObjectives,
    );
  }
}
