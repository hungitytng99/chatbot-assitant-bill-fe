import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class ErrorListWidget extends StatelessWidget {
  final String text;
  final RefreshCallback? onRefresh;

  const ErrorListWidget({
    Key? key,
    this.text = 'Đã xảy ra lỗi',
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text(
                  text,
                  style: AppTextStyle.greyS14Bold,
                ),
              ),
            );
          },
          itemCount: 1,
        ),
        onRefresh: onRefresh ?? _onRefreshData);
  }

  Future<void> _onRefreshData() async {}
}
