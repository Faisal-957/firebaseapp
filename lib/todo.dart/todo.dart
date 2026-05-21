import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TextEditingController taskController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addTodo() {
    if (taskController.text.trim().isEmpty) return;
    firestore.collection('todoos').add({'task': taskController.text.trim()});
    taskController.clear();
  }

  void deleteTodo(String Id) {
    firestore.collection('todoos').doc(Id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App")),
      body: Column(
        children: [
          TextField(
            controller: taskController,
            decoration: InputDecoration(labelText: "Enter a task"),
          ),
          29.verticalSpace,
          ElevatedButton(
            onPressed: () {
              addTodo();
            },
            child: Text("Add Task"),
          ),
          20.verticalSpace,
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection("todoos").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No tasks"));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data =
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;

                    return Card(
                      child: ListTile(
                        title: Text(data['task']),
                        trailing: IconButton(
                          onPressed: () {
                            deleteTodo(snapshot.data!.docs[index].id);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
