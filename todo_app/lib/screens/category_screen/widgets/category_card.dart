import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final int taskCount;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.taskCount,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        subtitle: Text('$taskCount Tasks'),
        onTap: onTap,
      ),
    );
  }
}
