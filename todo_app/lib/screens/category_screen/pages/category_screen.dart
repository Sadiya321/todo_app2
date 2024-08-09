import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/localization/languages/languages.dart';
import 'package:todo_app/theme/theme_const.dart';
import 'package:todo_app/widgets/app_textview.dart';

import '../widgets/category_card.dart';
import '../widgets/date_chips.dart'; // Import the scrollable date chips widget here

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({Key? key}) : super(key: key);

  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Example: Set the start date to the first of the current month and the end date to the last day of the current month.
    final startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    final endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          '01 August',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.alarm),
            color: Colors.black,
            onPressed: () {
              // Handle the action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollableDateChips(
              startDate: startDate,
              endDate: endDate,
              selectedDate: selectedDate,
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            const SizedBox(height: 24.0),
            AppTextView(
                text: Languages.of(context).chooseCat,
                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 18.sp,
                    color: Theme.of(context).colorScheme.textColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  CategoryCard(
                    title: 'Idea',
                    subtitle: 'Number of Task',
                    icon: Icons.lightbulb_outline,
                    onTap: () {
                      // Handle card tap
                    },
                  ),
                  CategoryCard(
                    title: 'Idea',
                    subtitle: 'Number of Task',
                    icon: Icons.lightbulb_outline,
                    onTap: () {
                      // Handle card tap
                    },
                  ),
                  CategoryCard(
                    title: 'Idea',
                    subtitle: 'Number of Task',
                    icon: Icons.lightbulb_outline,
                    onTap: () {
                      // Handle card tap
                    },
                  ),
                  CategoryCard(
                    title: 'Idea',
                    subtitle: 'Number of Task',
                    icon: Icons.lightbulb_outline,
                    onTap: () {
                      // Handle card tap
                    },
                  ), CategoryCard(
                    title: 'Idea',
                    subtitle: 'Number of Task',
                    icon: Icons.lightbulb_outline,
                    onTap: () {
                      // Handle card tap
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
