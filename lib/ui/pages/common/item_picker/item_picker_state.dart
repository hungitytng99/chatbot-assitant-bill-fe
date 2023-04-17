part of 'item_picker_cubit.dart';

class ItemPickerState extends Equatable {
  final List<String> data;
  final List<String> searchResult;
  final int? selectedIndex;
  final String? searchKeyword;

  const ItemPickerState({
    this.data = const [],
    this.searchResult = const [],
    this.selectedIndex,
    this.searchKeyword,
  });

  ItemPickerState copyWith({
    List<String>? data,
    List<String>? searchResult,
    int? selectedIndex,
    String? searchKeyword,
  }) {
    return ItemPickerState(
      data: data ?? this.data,
      searchResult: searchResult ?? this.searchResult,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      searchKeyword: searchKeyword ?? this.searchKeyword,
    );
  }

  @override
  List<Object> get props => [
        data,
        searchResult,
        selectedIndex ?? -1,
        searchKeyword ?? "",
      ];
}
