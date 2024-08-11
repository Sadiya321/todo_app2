import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/widgets/app_textfield.dart';
import 'package:todo_app/widgets/app_textview.dart';

import '../controller/task_controller.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _attachmentsController = TextEditingController();
  String _selectedCategory = 'Personal'; // Default category
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _deadlineDate;
  TimeOfDay? _deadlineTime;
  bool _isExpanded = false;

  final TaskController _taskController = Get.put(TaskController());

  void _createTask() async {
    await _taskController.createTask(
      title: _titleController.text,
      category: _selectedCategory,
      description: _descriptionController.text,
      startDate: _startDate,
      startTime: _startTime,
      deadlineDate: _deadlineDate,
      deadlineTime: _deadlineTime,
      attachments: _attachmentsController.text,
    );
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
                color: Colors.black,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  ),
            ),
            SizedBox(height: 10.h),
            _buildCategoryButtons(),
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
              controller: _attachmentsController,
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

  Widget _buildCategoryButtons() {
    List<String> categories = [
      'Personal',
      'Teams',
      'Work',
      'Shopping',
      'Health'
    ];

    List<String> displayedCategories = [_selectedCategory]
      ..addAll(categories.where((category) => category != _selectedCategory));

    int visibleCount = _isExpanded ? displayedCategories.length : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80.h,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 3,
            ),
            itemCount: visibleCount,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String category = displayedCategories[index];
              bool isSelected = _selectedCategory == category;
              return _buildCategoryButton(category, isSelected);
            },
          ),
        ),
        if (!_isExpanded && displayedCategories.length > 2)
          _buildShowMoreButton(),
        if (_isExpanded) _buildShowLessButton(),
      ],
    );
  }

  Widget _buildCategoryButton(String category, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category == 'Personal'
                  ? Icons.person
                  : category == 'Teams'
                      ? Icons.group
                      : category == 'Work'
                          ? Icons.work
                          : category == 'Shopping'
                              ? Icons.shopping_cart
                              : Icons.health_and_safety,
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
    );
  }

  Widget _buildShowMoreButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = true;
        });
      },
      child: Row(
        children: [
          AppTextView(
            text: 'Show More',
            textStyle: Theme.of(context).textTheme.button!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildShowLessButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = false;
        });
      },
      child: Row(
        children: [
          AppTextView(
            text: 'Show Less',
            textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Icon(
            Icons.arrow_drop_up,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDateAndTimePicker() {
    return Column(
      children: [
        Row(
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
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDeadlineDate(context),
                child: _buildDatePicker(
                  icon: Icons.calendar_today,
                  hint: _deadlineDate == null
                      ? 'Deadline Date'
                      : '${_deadlineDate!.toLocal()}'.split(' ')[0],
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDeadlineTime(context),
                child: _buildDatePicker(
                  icon: Icons.access_time,
                  hint: _deadlineTime == null
                      ? 'Deadline Time'
                      : _deadlineTime!.format(context),
                ),
              ),
            ),
          ],
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
            textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Theme.of(context).colorScheme.primary,
              dialBackgroundColor: Colors.grey[200],
              hourMinuteColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.selected)
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[200]!,
              ),
              hourMinuteTextColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.selected)
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectDeadlineDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadlineDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _deadlineDate) {
      setState(() {
        _deadlineDate = picked;
      });
    }
  }

  Future<void> _selectDeadlineTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _deadlineTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Theme.of(context).colorScheme.primary,
              dialBackgroundColor: Colors.grey[200],
              hourMinuteColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.selected)
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[200]!,
              ),
              hourMinuteTextColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.selected)
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _deadlineTime) {
      setState(() {
        _deadlineTime = picked;
      });
    }
  }
}
