import 'dart:convert'; // Import to use jsonEncode and jsonDecode
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/theme/theme_const.dart';
import 'package:todo_app/widgets/app_textview.dart';
import 'package:todo_app/widgets/app_textfield.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'Personal'; // Default category
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _deadlineDate;
  TimeOfDay? _deadlineTime;

  void _createTask() async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Prepare task data
    Map<String, dynamic> task = {
      'title': _titleController.text,
      'category': _selectedCategory,
      'description': _descriptionController.text,
      'startDate': _startDate?.toIso8601String(),
      'startTime': _startTime?.format(context),
      'deadlineDate': _deadlineDate?.toIso8601String(),
      'deadlineTime': _deadlineTime?.format(context),
    };

    // Convert the task map to a JSON string
    String taskJson = jsonEncode(task);

    // Save task to SharedPreferences as a JSON string
    String taskKey = 'task_${DateTime.now().millisecondsSinceEpoch}';
    await prefs.setString(taskKey, taskJson);

    // Print task data (for debugging)
    print('Task saved: $taskJson');

    // Navigate back or show a success message
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppTextView(
          text: 'New Task ToDo',
          textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.black, // Set title color
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Set background color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            AppTextField(
              controller: _titleController,
              hintText: 'Add Task Name..',
              title: 'Title Task',
              onValueChange: (value) {},
              maxLines: 1,
            ),
            SizedBox(height: 20.h),
            AppTextView(
              text: 'Category',
              textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryColor
                        .withOpacity(0.6),
                  ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                _buildCategoryButton(
                    'Personal', _selectedCategory == 'Personal'),
                SizedBox(width: 10.w),
                _buildCategoryButton('Teams', _selectedCategory == 'Teams'),
                SizedBox(width: 10.w),
                _buildDropDownArrow(), // Placeholder for the dropdown arrow
              ],
            ),
            SizedBox(height: 20.h),
            AppTextField(
              controller: _descriptionController,
              hintText: 'Add Descriptions..',
              title: 'Description',
              onValueChange: (value) {},
              maxLines: 3,
            ),
            SizedBox(height: 20.h),
            _buildDateAndTimePicker(),
            SizedBox(height: 20.h),
            AppTextField(
              controller:
                  TextEditingController(), // Placeholder for attachments/links
              hintText: 'Any relevant files or links',
              title: 'Attachments/Links',
              onValueChange: (value) {},
              maxLines: 2,
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCancelButton(),
                _buildCreateButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = category;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category == 'Personal' ? Icons.person : Icons.group,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 5.w),
              AppTextView(
                text: category,
                textStyle: Theme.of(context).textTheme.button!.copyWith(
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropDownArrow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildDateAndTimePicker() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectStartDate(context),
            child: _buildDatePicker(
              icon: Icons.calendar_today,
              hint: _startDate == null
                  ? 'Start Date'
                  : '${_startDate!.toLocal()}'.split(' ')[0],
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: GestureDetector(
            onTap: () => _selectStartTime(context),
            child: _buildDatePicker(
              icon: Icons.access_time,
              hint: _startTime == null
                  ? 'Start Time'
                  : _startTime!.format(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker({required IconData icon, required String hint}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 10.w),
          AppTextView(
            text: hint,
            textStyle: Theme.of(context).textTheme.button!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Remove circular radius
        ),
      ),
      child: AppTextView(
        text: "Cancel",
        textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton(
      onPressed: _createTask,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Remove circular radius
        ),
      ),
      child: AppTextView(
        text: "Create",
        textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }
}
