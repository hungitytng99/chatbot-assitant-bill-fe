part of 'contact_list_cubit.dart';

class ContactListState extends Equatable {
  final LoadStatus getActiveExpertsStatus;
  final LoadStatus getInActiveExpertsStatus;
  List<ExpertEntity> activeExperts;
  UpCommingExpertEntity? inActiveExperts;

  @override
  List<Object?> get props => [
        getActiveExpertsStatus,
        activeExperts,
        getInActiveExpertsStatus,
        inActiveExperts,
      ];

  ContactListState({
    this.getActiveExpertsStatus = LoadStatus.initial,
    this.activeExperts = const [],
    this.getInActiveExpertsStatus = LoadStatus.initial,
    this.inActiveExperts,
  });

  ContactListState copyWith({
    LoadStatus? getActiveExpertsStatus,
    List<ExpertEntity>? activeExperts,
    LoadStatus? getInActiveExpertsStatus,
    UpCommingExpertEntity? inActiveExperts,
  }) {
    return ContactListState(
      getActiveExpertsStatus:
          getActiveExpertsStatus ?? this.getActiveExpertsStatus,
      activeExperts: activeExperts ?? this.activeExperts,
      getInActiveExpertsStatus:
          getInActiveExpertsStatus ?? this.getInActiveExpertsStatus,
      inActiveExperts: inActiveExperts ?? this.inActiveExperts,
    );
  }
}
