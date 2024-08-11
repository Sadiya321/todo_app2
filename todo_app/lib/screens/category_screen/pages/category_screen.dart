import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/category_card.dart';
import '../widgets/date_chips.dart';
import 'category_task.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({Key? key}) : super(key: key);

  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    final endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '${selectedDate.day} ${_getMonthName(selectedDate.month)}',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.alarm),
            color: Colors.black,
            onPressed: () {
              // Handle the action
            },
          ),
        ],
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
            const Text(
              'Choose Category',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('categories').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String categoryName = data['name'] ?? 'Unnamed Category';

                      return FutureBuilder<int>(
                        future: _getTaskCount(categoryName),
                        builder: (context, taskSnapshot) {
                          return CategoryCard(
                            title: categoryName,
                            taskCount: taskSnapshot.data ?? 0,
                            icon: Icons.lightbulb_outline,
                            iconColor: Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryTasksScreen(
                                      categoryName: categoryName),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> _getTaskCount(String category) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("No user is logged in.");
    }

    QuerySnapshot taskSnapshot = await _firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('tasks')
        .where('category', isEqualTo: category)
        .get();

    return taskSnapshot.docs.length;
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }
}
