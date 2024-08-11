import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor; // Add this parameter
  final VoidCallback onTap; // Add this parameter

  const CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor, // Initialize the iconColor parameter
    required this.onTap, // Initialize the onTap parameter
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor, // Use the iconColor parameter
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap, // Use the onTap parameter
      ),
    );
  }
}
