import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to create a task and save it to Firestore
  Future<void> createTask({
    required String title,
    required String category,
    required String description,
    DateTime? startDate,
    TimeOfDay? startTime,
    DateTime? deadlineDate,
    TimeOfDay? deadlineTime,
    String? attachments,
    bool? isCompleted,
  }) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw Exception("No user is logged in.");
      }

      // Create a new document reference with an auto-generated ID
      DocumentReference taskDocRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('tasks')
          .doc();

      // Prepare task data including the auto-generated document ID
      Map<String, dynamic> taskData = {
        'title': title,
        'category': category,
        'description': description,
        'startDate': startDate?.toIso8601String(),
        'startTime': startTime?.format(Get.context!),
        'deadlineDate': deadlineDate?.toIso8601String(),
        'deadlineTime': deadlineTime?.format(Get.context!),
        'attachments': attachments,
        'createdAt': FieldValue.serverTimestamp(),
        'isCompleted': false,
        'id': taskDocRef.id, // Assign the document ID to the 'id' field
      };

      // Save the task data to Firestore
      await taskDocRef.set(taskData);

      Get.snackbar('Success', 'Task created successfully!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
