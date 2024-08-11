import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/custom_widgets/custom_appbar.dart';
import 'package:todo_app/screens/add_new_screen.dart';
import 'package:todo_app/widgets/app_textview.dart';

import 'category_screen/pages/category_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Stream<List<Map<String, dynamic>>> _getTasksForDay(DateTime date) {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("No user is logged in.");
    }

    return _firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('tasks')
        .where('startDate', isGreaterThanOrEqualTo: date.toIso8601String())
        .where('startDate',
            isLessThan: date.add(Duration(days: 1)).toIso8601String())
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(
                    Text('Content goes here'),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextView(
                              text: "Today",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: 5.h),
                            AppTextView(
                              text: "8 Task",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateTaskScreen(),
                                  ),
                                );
                              },
                              child: AppTextView(
                                text: "Add New",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            SizedBox(width: 0.01.sw),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.23,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(70.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // AppTextView(
                    //   text: "${_currentPage + 1} hour ago",
                    //   textStyle:
                    //       Theme.of(context).textTheme.bodySmall!.copyWith(
                    //             color: Theme.of(context)
                    //                 .colorScheme
                    //                 .primary
                    //                 .withOpacity(0.7),
                    //           ),
                    // ),
                    SizedBox(height: 10.h),
                    Expanded(
                      flex: 1,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (context, index) {
                          final date =
                              DateTime.now().add(Duration(days: index));
                          return StreamBuilder<List<Map<String, dynamic>>>(
                            stream: _getTasksForDay(date),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              }
                              final tasks = snapshot.data ?? [];
                              return TaskDay(
                                date: date,
                                tasks: tasks,
                                currentTime: DateTime.now(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CategorySelectionScreen(),
                          ),
                        );
                      },
                      child: AppTextView(
                        text: "Categories",
                        textStyle:
                            Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskDay extends StatefulWidget {
  final DateTime date;
  final List<Map<String, dynamic>> tasks;
  final DateTime currentTime;

  TaskDay({required this.date, required this.tasks, required this.currentTime});

  @override
  _TaskDayState createState() => _TaskDayState();
}

class _TaskDayState extends State<TaskDay> {
  late List<bool> _completedTasks;

  @override
  void initState() {
    super.initState();
    _completedTasks = widget.tasks
        .map((task) => task['isCompleted'] as bool? ?? false)
        .toList();
  }

  Future<void> _toggleTaskCompletion(int index, bool isCompleted) async {
    setState(() {
      _completedTasks[index] = isCompleted;
    });

    // Update the task completion status in Firestore
    String taskId =
        widget.tasks[index]['id']; // Assuming each task has a unique 'id'
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('tasks')
          .doc(taskId)
          .update({'isCompleted': isCompleted});
    }
  }

  @override
  Widget build(BuildContext context) {
    String hoursAgo = _calculateHoursAgo();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('d').format(widget.date),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('E').format(widget.date),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              hoursAgo,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: widget.tasks.length,
            itemBuilder: (context, index) {
              return _buildTaskItem(
                context,
                widget.tasks[index]['title'],
                "${widget.tasks[index]['startTime']} - ${widget.tasks[index]['deadlineTime']}",
                _completedTasks[index],
                index == 1,
                (value) => _toggleTaskCompletion(index, value!),
              );
            },
          ),
        ),
      ],
    );
  }

  String _calculateHoursAgo() {
    Duration difference = widget.currentTime.difference(widget.date);
    int hours = difference.inHours;
    if (hours == 0) {
      return "Just now";
    } else if (hours == 1) {
      return "1 hour ago";
    } else {
      return "$hours hours ago";
    }
  }

  Widget _buildTaskItem(BuildContext context, String task, String time,
      bool isCompleted, bool highlight, ValueChanged<bool?> onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: highlight ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: onChanged,
          activeColor: highlight ? Colors.white : Colors.blue,
          checkColor: highlight ? Colors.blue : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        title: Text(
          task,
          style: TextStyle(
            color: highlight ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            decoration:
                isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          time,
          style: TextStyle(
            color: highlight ? Colors.white70 : Colors.black54,
            fontSize: 12,
          ),
        ),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
