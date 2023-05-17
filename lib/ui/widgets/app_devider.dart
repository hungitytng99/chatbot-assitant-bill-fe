import 'package:flutter/material.dart';

class AppDivider extends Divider {
  @override
  final double? indent;
  @override
  final double? endIndent;

  const AppDivider({this.indent = 0, this.endIndent = 0})
      : super(
          color: Colors.grey,
          height: 1,
          indent: indent,
          endIndent: endIndent,
        );
}
