// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/widgets/app_textview.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar(
    Text text, {
    Key? key,
    this.height = 20.0, // Set to a more appropriate default height
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String date;

  @override
  void initState() {
    super.initState();
    // Initialize the date with the current date or a default value
    date = _formatDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        toolbarHeight: widget.height.h,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: Icon(Icons.menu, color: Theme.of(context).colorScheme.surface),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _showDatePicker(context),
              child: Row(
                children: [
                  // Icon(Icons.menu,
                  //     color: Theme.of(context).colorScheme.surface),
                  // SizedBox(width: 16), // Adjust the spacing as needed
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () => _showDatePicker(context),
                  child: AppTextView(
                    // textAlign: TextAlign.center,
                    text: date,
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                ),
              ),
            ),
            Icon(Icons.timer, color: Theme.of(context).colorScheme.surface),
          ],
        ),
        centerTitle: true,
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).colorScheme.primary,
            hintColor: Theme.of(context).colorScheme.primary,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        date = _formatDate(selectedDate);
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} ${_monthName(date.month)} ${date.year}";
  }

  String _monthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
