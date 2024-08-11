import 'dart:convert'; // Import to use jsonDecode
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
void _saveTask(String key, Map<String, dynamic> task) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, jsonEncode(task));
}

// Sample task with formatted dates
Map<String, dynamic> task = {
  'title': 'Task Title',
  'description': 'Task Description',
  'deadline': '2024-12-31T23:59:59', // ISO8601 format
  'createdAt': '2024-08-10T12:00:00', // ISO8601 format
};

  void _loadTasks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> keys = prefs.getKeys();
  List<Map<String, dynamic>> loadedTasks = [];

  for (String key in keys) {
    if (key.startsWith('task_')) {
      String? taskString = prefs.getString(key);
      if (taskString != null) {
        try {
          Map<String, dynamic> task = jsonDecode(taskString);

          // Check if required fields are present
          if (task.containsKey('deadline') && task.containsKey('createdAt')) {
            // Optional: parse dates if necessary
            // Example: DateTime.parse(task['deadline']);
            loadedTasks.add(task);
          }
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


void _showTaskDetails(Map<String, dynamic> task) {
  // Parse dates from ISO8601 format if necessary
  DateTime deadline = DateTime.parse(task['deadline']);
  DateTime createdAt = DateTime.parse(task['createdAt']);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(task['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${task['description']}'),
            SizedBox(height: 8.0),
            Text('Deadline: ${DateFormat('yyyy-MM-dd').format(deadline)}'),
            SizedBox(height: 8.0),
            Text('Created At: ${DateFormat('yyyy-MM-dd').format(createdAt)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    final endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
    final iconColor = Theme.of(context).colorScheme.primary; // Get primary color for icons

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
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return CategoryCard(
                    title: task['title'],
                    subtitle: task['description'],
                    icon: Icons.task_alt, // Use an appropriate icon for tasks
                    iconColor: iconColor, // Pass the iconColor parameter
                    onTap: () {
                      _showTaskDetails(task); // Show task details on tap
                    },
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
