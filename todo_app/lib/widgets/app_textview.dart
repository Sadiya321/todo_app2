
import 'package:flutter/material.dart';
import 'package:todo_app/const/responsive_size_const.dart';

class AppTextView extends StatefulWidget {
  const AppTextView({
    super.key,
    this.fontSize = 14,
    this.textStyle,
    required this.text,
    this.textAlign = TextAlign.start,
    this.isMaxLine = false,
    this.maxLines,
    this.overflow,

  });

  final double fontSize;
  final TextStyle? textStyle;
  final String? text;
  final TextAlign textAlign;
  final bool isMaxLine;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  State<AppTextView> createState() => _AppTextViewState();
}

class _AppTextViewState extends State<AppTextView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var fontSize = widget.fontSize;

        if (width <= ResponsiveSizes.mobile) {
          fontSize = widget.fontSize;
        } else if (width <= ResponsiveSizes.tablet) {
          fontSize = widget.fontSize + 12;
        }

        return Text(
          widget.text ?? "",
          textAlign: widget.textAlign,
          style: widget.textStyle ?? Theme.of(context).textTheme.labelMedium,
          maxLines: widget.maxLines ?? (widget.isMaxLine ? 5 : 1),
          overflow: widget.overflow ?? TextOverflow.ellipsis,
        );
      },
    );
  }
}