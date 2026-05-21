import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgets_practicing/student_data.dart/student.dart';
import 'package:widgets_practicing/student_data.dart/student_viewmodel.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentViewsModel>(
      builder: (context, val, child) => Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentScreen()),
                );
              },
              child: Text("Skip"),
            ),
          ],

          backgroundColor: Colors.white,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('students').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Students"));
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        tileColor: Colors.white,
                        title: Text(
                          "Name: ${data['name']}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "RollNo:${data['rollNo']}",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Class:${data['class']}",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Age:${data['age']}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                final provider = Provider.of<StudentViewsModel>(
                                  context,
                                  listen: false,
                                );

                                provider.deleteData(data.id);
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                final provider = Provider.of<StudentViewsModel>(
                                  context,
                                  listen: false,
                                );

                                final Map<String, dynamic> map =
                                    Map<String, dynamic>.from(
                                      data.data() as Map<String, dynamic>,
                                    );

                                provider.loadDataForEdit(map, data.id);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
