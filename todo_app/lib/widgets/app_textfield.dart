
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/theme/theme_const.dart';
import 'package:todo_app/widgets/app_textview.dart';

class AppTextField extends StatefulWidget {
  final String title;
  final FormFieldValidator<String>? validator;
  final String? initialValue; // Renamed from value to initialValue
  final ValueChanged<String>? onValueChange;
  final ValueChanged<String>? onSubmit;
  final bool multiline;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  final bool enabled;
  final bool autoFocus;
  final bool obscureText;
  final Widget? suffixIcon;
  final AutovalidateMode? autoValidate;
  final TextStyle? labelStyle;

  const AppTextField({
    super.key,
    required this.title,
    this.validator,
    this.initialValue, // Use this parameter for default value
    required this.onValueChange,
    this.multiline = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onTap,
    this.controller,
    this.focusNode,
    this.onSubmit,
    this.enabled = true,
    this.autoFocus = true,
    this.suffixIcon,
    this.obscureText = false,
    this.autoValidate,
    this.labelStyle, required int maxLines, required String hintText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  void initState() {
    super.initState();
    // Initialize the controller's text with the initial value
    if (widget.controller != null) {
      widget.controller!.text = widget.initialValue ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 15.w),
              AppTextView(
                text: widget.title,
                textStyle: widget.labelStyle ?? Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.primaryColor.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                spreadRadius: 0.5,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ]),
            child: TextFormField(
              autovalidateMode: widget.autoValidate,
              controller: widget.controller,
              autofocus: widget.autoFocus,
              enabled: widget.enabled,
              textInputAction: TextInputAction.done,
              keyboardType: widget.keyboardType,
              focusNode: widget.focusNode,
              validator: widget.validator,
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.white,
                filled: true,
                suffixIcon: widget.suffixIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                // contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 10.w),
              ),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 16.sp,
              ),
              onFieldSubmitted: widget.onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}