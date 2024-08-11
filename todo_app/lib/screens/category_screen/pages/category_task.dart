import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryTasksScreen extends StatelessWidget {
  final String categoryName;

  CategoryTasksScreen({Key? key, required this.categoryName}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Tasks'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No tasks in this category.'));
          }

          return ListView(
            padding: EdgeInsets.all(16),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return TaskCard(
                task: data,
                taskId: document.id,
                userId: _auth.currentUser!.uid, // Pass the user ID
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> _getTasks() {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("No user is logged in.");
    }

    return _firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('tasks')
        .where('category', isEqualTo: categoryName)
        .snapshots();
  }
}

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final String taskId;
  final String userId;

  const TaskCard({
    Key? key,
    required this.task,
    required this.taskId,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['title'] ?? 'Untitled Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(task['description'] ?? 'No description'),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 4),
                Text(_formatDate(task['startDate'])),
                SizedBox(width: 16),
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text(task['startTime'] ?? 'No start time'),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.flag, size: 16),
                SizedBox(width: 4),
                Text(_formatDate(task['deadlineDate'])),
                SizedBox(width: 16),
                Icon(Icons.alarm, size: 16),
                SizedBox(width: 4),
                Text(task['deadlineTime'] ?? 'No deadline time'),
              ],
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => _deleteTask(context),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'No date';
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM d, y').format(date);
  }

  void _deleteTask(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task: $e')),
      );
    }
  }
}
