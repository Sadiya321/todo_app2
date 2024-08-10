import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  DateTime? _deadlineDate;

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
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                _buildCategoryButton('Personal', _selectedCategory == 'Personal'),
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
              controller: TextEditingController(), // Placeholder for attachments/links
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
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
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
                    : Icons.group,
                color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 5.w),
              AppTextView(
                text: category,
                textStyle: Theme.of(context).textTheme.button!.copyWith(
                      color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
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
      child:  Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary,),
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
                  ? 'dd/mm/yy'
                  : '${_startDate!.toLocal()}'.split(' ')[0],
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDeadlineDate(context),
            child: _buildDatePicker(
              icon: Icons.access_time,
              hint: _deadlineDate == null
                  ? 'hh:mm'
                  : '${_deadlineDate!.toLocal()}'.split(' ')[1],
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
          Icon(icon, color: Theme.of(context).colorScheme.primary,),
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
      textStyle: Theme.of(context).textTheme.button!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
