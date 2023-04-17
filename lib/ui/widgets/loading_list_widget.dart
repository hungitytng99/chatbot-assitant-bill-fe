import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_dimens.dart';

import 'loading_row_widget.dart';

class LoadingListWidget extends StatelessWidget {
  final EdgeInsets? rowPadding;
  final double rowHeight;

   const LoadingListWidget({Key? key, this.rowPadding, this.rowHeight = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimens.paddingNone),
      itemBuilder: (context, index) {
        return LoadingRowWidget(padding: rowPadding, height: rowHeight);
      },
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
