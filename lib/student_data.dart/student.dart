import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  void submitData() async {
    String name = nameController.text.trim();
    String rollNo = rollNoController.text.trim();
    String studentClass = classController.text.trim();
    int age = int.tryParse(ageController.text.trim()) ?? 0;

    if (name.isEmpty || rollNo.isEmpty || studentClass.isEmpty || age <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields with valid data")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await _firestore.collection('students').add({
        'name': name,
        'rollNo': rollNo,
        'class': studentClass,
        'age': age,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Student data submitted successfully")),
      );
      setState(() {
        isLoading = false;
      });

      nameController.clear();
      rollNoController.clear();
      classController.clear();
      ageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error submitting data: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Student Form',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            10.verticalSpace,

            TextField(
              controller: rollNoController,
              decoration: InputDecoration(labelText: "Roll No"),
            ),
            10.verticalSpace,

            TextField(
              controller: classController,
              decoration: InputDecoration(labelText: "Class"),
            ),
            10.verticalSpace,

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Age"),
            ),
            20.verticalSpace,
            Center(
              child: SizedBox(
                height: 50.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff02C778),
                  ),

                  onPressed: isLoading ? null : submitData,
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "Submit",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
