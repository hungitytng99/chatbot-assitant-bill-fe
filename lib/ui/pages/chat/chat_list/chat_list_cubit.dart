import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/conversation_history_entity.dart';
import 'package:ihz_bql/models/entities/conversation_history_item_entity.dart';
import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/conversation_repository.dart';
import 'package:ihz_bql/repositories/expert_repository.dart';
part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  ExpertRepository expertRepository;
  ConversationsRepository conversationsRepository;

  ChatListCubit({
    required this.expertRepository,
    required this.conversationsRepository,
  }) : super(ChatListState());

  Future<void> getActiveExpert() async {
    emit(state.copyWith(getActiveExpertsStatus: LoadStatus.loading));
    try {
      final List<ExpertEntity> result = await expertRepository.getActive();

      emit(state.copyWith(
        getActiveExpertsStatus: LoadStatus.success,
        activeExperts: result,
      ));
    } catch (e) {
      emit(state.copyWith(getActiveExpertsStatus: LoadStatus.failure));
    }
  }

  Future<List<ConversationHistoryItemEntity>> getListConversationHistories(
      {int page = 1, int limit = 10}) async {
    emit(state.copyWith(getConversationHistoriesStatus: LoadStatus.loading));
    try {
      final ConversationHistoryEntity result = await conversationsRepository
          .getConversationHistories(page: page, limit: limit);
      return result.conversations;
    } catch (e) {
      return [];
    }
  }
}
