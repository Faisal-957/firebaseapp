import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';

import 'package:widgets_practicing/noteapp/add.screen.dart';
import 'package:widgets_practicing/noteapp/noteviewmodel.dart';

class Notehome extends StatelessWidget {
  const Notehome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotepadViewmodel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,

          title: const Text(
            "My Notes",

            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          centerTitle: true,
        ),

        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: value.notesRef.snapshots(),

            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length,

                itemBuilder: (context, index) {
                  final doc = docs[index];

                  return Card(
                    margin: const EdgeInsets.all(8),

                    child: ListTile(
                      tileColor: Colors.white,

                      // TITLE
                      title: Text(
                        doc['title'],

                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        doc['description'],

                        style: const TextStyle(fontSize: 18),
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),

                            onPressed: () {
                              value.deleteNote(doc.id);
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),

                            onPressed: () {
                              value.editNote(doc);
                              Get.to(NotepadScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,

          onPressed: () {
            value.isEdit = false;

            value.titlecontroller.clear();

            value.descriptioncontroller.clear();

            Get.to(NotepadScreen());
          },

          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
