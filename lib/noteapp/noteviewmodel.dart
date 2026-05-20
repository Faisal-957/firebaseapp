import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotepadViewmodel extends ChangeNotifier {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final CollectionReference notesRef = FirebaseFirestore.instance.collection(
    'notes',
  );

  bool isEdit = false;
  String? editingDocId;

  Future<void> addNote() async {
    if (titlecontroller.text.isEmpty) return;

    await notesRef.add({
      'title': titlecontroller.text,
      'description': descriptioncontroller.text,

      // 'time': FieldValue.serverTimestamp(),
    });

    titlecontroller.clear();
    descriptioncontroller.clear();
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    await notesRef.doc(id).delete();
    notifyListeners();
  }

  void editNote(DocumentSnapshot doc) {
    editingDocId = doc.id;
    isEdit = true;

    titlecontroller.text = doc["title"];
    descriptioncontroller.text = doc["description"];

    notifyListeners();
  }

  Future<void> updateNote(String id) async {
    await notesRef.doc(id).update({
      'title': titlecontroller.text,
      'description': descriptioncontroller.text,
    });

    isEdit = false;
    editingDocId = null;

    titlecontroller.clear();
    descriptioncontroller.clear();

    notifyListeners();
  }
}
