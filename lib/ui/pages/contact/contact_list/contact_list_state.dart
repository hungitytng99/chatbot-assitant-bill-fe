part of 'contact_list_cubit.dart';

class ContactListState extends Equatable {
  final LoadStatus getActiveExpertsStatus;
  List<ExpertEntity> activeExperts;

  @override
  List<Object?> get props => [
        getActiveExpertsStatus,
        activeExperts,
      ];

  ContactListState({
    this.getActiveExpertsStatus = LoadStatus.initial,
    this.activeExperts = const [],
  });

  ContactListState copyWith({
    LoadStatus? getActiveExpertsStatus,
    List<ExpertEntity>? activeExperts,
  }) {
    return ContactListState(
      getActiveExpertsStatus:
          getActiveExpertsStatus ?? this.getActiveExpertsStatus,
      activeExperts: activeExperts ?? this.activeExperts,
    );
  }
}
