part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int currentPage;

  @override
  List<Object?> get props => [currentPage];

  const HomeState({
    required this.currentPage,
  });

  HomeState copyWith({int? currentPage}) {
    return HomeState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
