import 'dart:convert'; // Import to use jsonDecode
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/widgets/app_textview.dart';

import '../widgets/category_card.dart';
import '../widgets/date_chips.dart'; // Import the scrollable date chips widget here

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({Key? key}) : super(key: key);

  @override
  _CategorySelectionScreenState createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> tasks = []; // List to store the tasks

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks when the screen is initialized
  }

 void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    List<Map<String, dynamic>> loadedTasks = [];

    // Iterate through keys and load tasks that match the pattern
    for (String key in keys) {
      if (key.startsWith('task_')) {
        String? taskString = prefs.getString(key);
        if (taskString != null) {
          try {
            Map<String, dynamic> task = jsonDecode(taskString); // Properly decode the JSON string
            loadedTasks.add(task);
          } catch (e) {
            print('Error decoding task: $e');
          }
        }
      }
    }

    setState(() {
      tasks = loadedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    final endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

    return Scaffold(
      appBar: AppBar(
        title: AppTextView(
          text: 'Categories',
          textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary, // Set text color
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.surface,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary, // Ensure icons and text are visible
        ),
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
                text: 'Choose Category',
                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 18.sp,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),
            Expanded(
              child:  ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task['title']),
            subtitle: Text(task['description']),
          );
        },
      ),
            ),
          ],
        ),
      ),
    );
  }
}
