part of 'chat_list_cubit.dart';

class ChatListState extends Equatable {
  final LoadStatus getActiveExpertsStatus;
  final List<ExpertEntity> activeExperts;

  final LoadStatus getConversationHistoriesStatus;
  final ConversationHistoryEntity? conversationHistoryEntity;

  @override
  List<Object?> get props => [
        getActiveExpertsStatus,
        activeExperts,
        getConversationHistoriesStatus,
        conversationHistoryEntity,
      ];

  ChatListState({
    this.getActiveExpertsStatus = LoadStatus.initial,
    this.activeExperts = const [],
    this.getConversationHistoriesStatus = LoadStatus.initial,
    this.conversationHistoryEntity,
  });

  ChatListState copyWith({
    LoadStatus? getActiveExpertsStatus,
    List<ExpertEntity>? activeExperts,
    LoadStatus? getConversationHistoriesStatus,
    ConversationHistoryEntity? conversationHistoryEntity,
  }) {
    return ChatListState(
      getActiveExpertsStatus:
          getActiveExpertsStatus ?? this.getActiveExpertsStatus,
      activeExperts: activeExperts ?? this.activeExperts,
      conversationHistoryEntity:
          conversationHistoryEntity ?? this.conversationHistoryEntity,
      getConversationHistoriesStatus:
          getConversationHistoriesStatus ?? this.getConversationHistoriesStatus,
    );
  }
}
