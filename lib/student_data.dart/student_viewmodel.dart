import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentViewsModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  String editingDocId = "";
  bool get isEditing => editingDocId.isNotEmpty;

  // ---------------- SUBMIT ----------------
  Future<void> submitData(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await _firestore.collection('students').add({
        'name': nameController.text.trim(),
        'rollNo': rollNoController.text.trim(),
        'class': classController.text.trim(),
        'age': int.tryParse(ageController.text.trim()) ?? 0,
      });

      clearFields();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Student Added")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    isLoading = false;
    notifyListeners();
  }

  // ---------------- EDIT LOAD ----------------
  void loadDataForEdit(Map<String, dynamic> data, String docId) {
    editingDocId = docId;

    nameController.text = data['name'] ?? "";
    rollNoController.text = data['rollNo'] ?? "";
    classController.text = data['class'] ?? "";
    ageController.text = data['age'].toString();

    notifyListeners();
  }

  // ---------------- UPDATE ----------------
  Future<void> updateData(BuildContext context) async {
    await _firestore.collection('students').doc(editingDocId).update({
      'name': nameController.text.trim(),
      'rollNo': rollNoController.text.trim(),
      'class': classController.text.trim(),
      'age': int.tryParse(ageController.text.trim()) ?? 0,
    });

    clearFields();
    editingDocId = "";

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Updated Successfully")));

    notifyListeners();
  }

  // ---------------- DELETE ----------------
  Future<void> deleteData(String id) async {
    await _firestore.collection('students').doc(id).delete();
  }

  // ---------------- CLEAR ----------------
  void clearFields() {
    nameController.clear();
    rollNoController.clear();
    classController.clear();
    ageController.clear();
  }
}
