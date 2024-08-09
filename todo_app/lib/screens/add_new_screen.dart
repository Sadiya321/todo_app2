import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/widgets/app_textview.dart';
import 'package:todo_app/widgets/app_textfield.dart';
import 'package:todo_app/widgets/app_language_drop_down.dart'; // Adjust the path if necessary

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'Work'; // Default category
  DateTime? _startDate;
  DateTime? _deadlineDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true, // Ensure the screen resizes to avoid the keyboard
      appBar: AppBar(
        title: AppTextView(
          text: 'Task Title',
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView( // Wrap the entire content in SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              AppTextField(
                controller: _titleController,
                hintText: 'Enter task title',
                title: 'Task Title',
                onValueChange: (value) {},
                maxLines: 2,
              ),
              SizedBox(height: 20.h),
              AppTextView(
                text: 'Category',
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10.h),
              AppLanguageDropDown(
                value: _selectedCategory,
                items: ['Work', 'Personal', 'Other'],
                onValueChange: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              SizedBox(height: 20.h),
              AppTextView(
                text: 'Description',
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10.h),
              AppTextField(
                controller: _descriptionController,
                hintText: 'Enter task description',
                title: 'Description',
                onValueChange: (value) {},
                maxLines: 5,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextView(
                          text: 'Start Date & Time',
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () => _selectStartDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                SizedBox(width: 10.w),
                                Text(
                                  _startDate == null
                                      ? 'Select start date'
                                      : '${_startDate!.toLocal()}'
                                          .split(' ')[0],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextView(
                          text: 'Deadline Date & Time',
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () => _selectDeadlineDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                SizedBox(width: 10.w),
                                Text(
                                  _deadlineDate == null
                                      ? 'Select deadline date'
                                      : '${_deadlineDate!.toLocal()}'
                                          .split(' ')[0],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Center(
                child: ElevatedButton(
                  onPressed: _createTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: AppTextView(
                    text: "Create Task",
                    textStyle:
                        Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).colorScheme.primary,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: Theme.of(context).colorScheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _startDate = selectedDate;
      });
    }
  }

  Future<void> _selectDeadlineDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).colorScheme.primary,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: Theme.of(context).colorScheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _deadlineDate = selectedDate;
      });
    }
  }

  void _createTask() {
    // Add your task creation logic here
    print('Title: ${_titleController.text}');
    print('Category: $_selectedCategory');
    print('Description: ${_descriptionController.text}');
    print('Start Date: $_startDate');
    print('Deadline Date: $_deadlineDate');
  }
}
