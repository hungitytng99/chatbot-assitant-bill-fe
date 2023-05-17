import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class HighlightText extends StatelessWidget {
  String text;
  String highlight;
  bool ignoreCase;

  HighlightText({
    Key? key,
    required this.text,
    required this.highlight,
    TextStyle? highlightStyle,
    this.ignoreCase = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    if ((highlight.isEmpty) || text.isEmpty) {
      return Text(text, style: AppTextStyle.blackS14);
    }

    var sourceText = ignoreCase ? text.toLowerCase() : text;
    var targetHighlight = ignoreCase ? highlight.toLowerCase() : highlight;

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = sourceText.indexOf(targetHighlight, start);
      if (indexOfHighlight < 0) {
        // no highlight
        spans.add(_normalSpan(text.substring(start)));
        break;
      }
      if (indexOfHighlight > start) {
        // normal text before highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
      }
      start = indexOfHighlight + highlight.length;
      spans.add(_highlightSpan(text.substring(indexOfHighlight, start)));
    } while (true);

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: AppTextStyle.blackS14Bold);
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: AppTextStyle.blackS14);
  }
}
