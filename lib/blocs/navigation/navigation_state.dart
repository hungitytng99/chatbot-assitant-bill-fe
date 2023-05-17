part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
 NavigationState({
  this.currentRoute,
  this.routeStack,
 });
 final String? currentRoute;
 final List<String>? routeStack;
 factory NavigationState.initial() => NavigationState(currentRoute: Routes.root, routeStack: []);
 NavigationState copyWith({String? currentRoute, List<String>? routeStack}) =>
     NavigationState(
         currentRoute: currentRoute ?? this.currentRoute,
         routeStack: routeStack ?? this.routeStack);
 @override
 List<Object?> get props =>
     [currentRoute, routeStack]..addAll(routeStack ?? []);
}