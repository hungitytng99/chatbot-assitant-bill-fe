import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/app_button_close.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';
import 'package:ihz_bql/ui/widgets/textfields/app_text_field.dart';

import 'item_picker_cubit.dart';

class ItemPickerPage extends StatefulWidget {
  final String? titlePage;
  final String? hintText;
  final List<String> data;
  final int? selectedIndex;

  const ItemPickerPage({
    Key? key,
    this.titlePage,
    this.hintText = "Tìm kiếm",
    this.data = const [],
    this.selectedIndex,
  }) : super(key: key);

  @override
  _ItemPickerPageState createState() => _ItemPickerPageState();
}

class _ItemPickerPageState extends State<ItemPickerPage> {
  late ItemPickerCubit cubit;

  @override
  void initState() {
    cubit = ItemPickerCubit();
    super.initState();
    cubit.setData(widget.data, widget.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
            alignment: Alignment.bottomCenter,
            child: buildBodyWidget()),
      ),
    );
  }


  Widget buildBodyWidget() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingS12,horizontal: AppDimens.paddingS12),
            child: Column(
              children: [
                const SizedBox(height: 15),
                AppLabelText(
                  labelText: widget.titlePage ?? '',
                  labelStyle: AppTextStyle.blackS16Bold,
                ),
                const SizedBox(height: 20),
                const Divider(
                  height: 0.5,
                ),
                const SizedBox(height: 10),
                Container(
                  child: AppTextField(
                    hintText: "Tìm kiếm",
                    onChanged: (text) {
                      cubit.onSearch(text);
                    },
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppDimens.paddingS9),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: _buildListResult(),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 12,
            child: Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    Get.back();
                  },
                  child: const AppButtonClose()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListResult() {
    return BlocBuilder<ItemPickerCubit, ItemPickerState>(
        bloc: cubit,
        buildWhen: (prev, current) {
          return prev.searchKeyword != current.searchKeyword;
        },
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            // new
            itemCount: (state.searchResult).length,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) {
              return Container(
                height: 15,
                margin: const EdgeInsets.symmetric(
                    horizontal: AppDimens.marginSmall),
                child: _buildLineDash(),
              );
            },
            itemBuilder: (context, index) {
              String title = state.searchResult[index];
              bool isSelected = (index == state.selectedIndex);
              return GestureDetector(
                onTap: () {
                  int selectedIndex =
                      state.data.indexOf(state.searchResult[index]);
                  Navigator.of(context).pop(selectedIndex);
                },
                child: _buildListItem(title, isSelected),
              );
            },
          );
        });
  }

  Widget _buildLineDash() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 0.5,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.gray),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }

  Widget _buildListItem(String title, bool isSelected) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingS12, vertical: AppDimens.paddingS8),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Text(
              title,
              // // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              // style: AppTextStyle.blackS14,
            ),
          ),
          Visibility(
              visible: isSelected,
              child: Icon(
                Icons.check,
                color: AppColors.main,
              ))
        ],
      ),
    );
  }
}
