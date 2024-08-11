import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo_app/custom_widgets/custom_appbar.dart';
import 'package:todo_app/screens/add_new_screen.dart';
import 'package:todo_app/screens/all_categories/all_categories.dart';
import 'package:todo_app/screens/category_screen/pages/category_screen.dart';
import 'package:todo_app/theme/theme_const.dart';
import 'package:todo_app/widgets/app_textview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
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
                                        const CreateTaskScreen(), // Replace with the actual dashboard screen
                                  ),
                                );
                              },
                              child: AppTextView(
                                text: "Add New",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            SizedBox(width:0.01.sw),
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
                                    AllCategories(),
                                        // const CategorySelectionScreen(),
                                  ),
                                );
                              },
                              child: AppTextView(
                                text: "Categories",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),

                          ],
                        ),


                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom container
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Calendar Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                            child: AppTextView(
                              text: "1",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                            ),
                          ),
                        ),
                        AppTextView(
                          text: "8 hour ago",
                          textStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                  ),
                        ),
                      ],
                    ),
                    // Task List
                    Expanded(
                      child: ListView(
                        children: [
                          _buildTaskItem(
                            context,
                            "Buy a pack of coffee",
                            "09:30 - 10:00",
                            true,
                          ),
                          _buildTaskItem(
                            context,
                            "Add new partners",
                            "11:30 - 13:30",
                            false,
                            true, // highlight this task
                          ),
                          _buildTaskItem(
                            context,
                            "Add new partners",
                            "14:15 - 15:00",
                          ),
                          _buildTaskItem(
                            context,
                            "Meeting on project",
                            "16:30 - 17:00",
                          ),
                          _buildTaskItem(
                            context,
                            "Work on project",
                            "18:00 - 19:00",
                          ),
                          
                        ],
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

  Widget _buildTaskItem(BuildContext context, String task, String time,
      [bool isCompleted = false, bool highlight = false]) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: highlight
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: highlight
            ? [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: isCompleted,
                onChanged: (value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              AppTextView(
                text: task,
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: highlight
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
          AppTextView(
            text: time,
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: highlight
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.greyLight,
                ),
          ),
        ],
      ),
    );
  }
}
