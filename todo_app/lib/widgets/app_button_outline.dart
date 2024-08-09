import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/theme/theme_const.dart';

class AppButtonOutlined extends StatefulWidget {
  const AppButtonOutlined(
      {super.key,
      required this.onTap,
      required this.buttonLabel,
      this.buttonStyle,
      this.buttonColor,
      this.labelStyle});

  final Function() onTap;
  final String buttonLabel;
  final ButtonStyle? buttonStyle;
  final Color? buttonColor;
  final TextStyle? labelStyle;

  @override
  State<AppButtonOutlined> createState() => _AppButtonOutlinedState();
}

class _AppButtonOutlinedState extends State<AppButtonOutlined> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 0.93.sw, height: 0.058.sh),
      child: OutlinedButton(
          style: widget.buttonStyle ??
              OutlinedButton.styleFrom(
                  side: BorderSide(
                      width: 2.0, color: Theme.of(context).colorScheme.white)),
          onPressed: widget.onTap,
          child: Text(
            widget.buttonLabel,
            style: widget.labelStyle,
          )),
    );
  }
}