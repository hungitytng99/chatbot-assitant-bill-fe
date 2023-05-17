import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/expert_repository.dart';
part 'contact_list_state.dart';

class ContactListCubit extends Cubit<ContactListState> {
  ExpertRepository expertRepository;

  ContactListCubit({
    required this.expertRepository,
  }) : super(ContactListState());

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
}
