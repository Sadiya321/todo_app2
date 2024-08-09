import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/theme/theme_const.dart';

class AppButtonFloating extends StatefulWidget {

  final Function() onTap;
  final String buttonLabel;
  final Color? buttonColor;
  final bool? isEnable;
  final ButtonStyle? buttonStyle;

  const AppButtonFloating({super.key,
    required this.onTap,
    required this.buttonLabel,
    this.buttonColor,
    this.isEnable = true,
    this.buttonStyle});

  @override
  State<AppButtonFloating> createState() => _AppButtonFloatingState();
}

class _AppButtonFloatingState extends State<AppButtonFloating> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 1.sw, height: 56),
      child: FloatingActionButton(
          child: Text(widget.buttonLabel ,
            style: TextStyle(
              color: widget.buttonColor ?? Theme.of(context).secondaryHeaderColor,
              fontSize: 18),
          ),
          // backgroundColor: widget.isEnable ? widget.buttonColor ?? Theme.of(context).colorScheme.primaryColor : Theme.of(context).colorScheme.grey,
          backgroundColor: Theme.of(context).colorScheme.primaryColor ,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          onPressed: widget.onTap
      ),
    );
  }
}