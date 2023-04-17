import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/utils/utils.dart';

part 'item_picker_state.dart';

class ItemPickerCubit extends Cubit<ItemPickerState> {
  ItemPickerCubit() : super(const ItemPickerState());

  void setData(List<String> data, int? selectedIndex) {
    emit(state.copyWith(
      data: data,
      searchResult: data,
      selectedIndex: selectedIndex ?? -1,
    ));
  }

  void onSearch(String keyword) {
    final result = state.data.where((element) {
      return Utils.isTextContainKeyword(text: element, keyword: keyword);
    }).toList();
    emit(state.copyWith(searchKeyword: keyword, searchResult: result));
  }
}
