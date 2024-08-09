import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widgets/app_textview.dart';

class ScrollableDateChips extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const ScrollableDateChips({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 70.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: endDate.difference(startDate).inDays + 1,
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));
          return DateChip(
            date: date,
            selected: date == selectedDate,
            onTap: () {
              onDateSelected(date);
            },
          );
        },
      ),
    );
  }
}

class DateChip extends StatelessWidget {
  final DateTime date;
  final bool selected;
  final VoidCallback onTap;

  const DateChip({
    Key? key,
    required this.date,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('E').format(date); // Abbreviated day name (Mon, Tue, etc.)
    final day = date.day.toString(); // Day number

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextView(
              text:day,
              textStyle: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppTextView(
              text:dayName,
              textStyle: TextStyle(
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
