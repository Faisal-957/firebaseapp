import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

import 'package:provider/provider.dart';
import 'package:widgets_practicing/noteapp/noteapp.dart';
import 'package:widgets_practicing/noteapp/noteviewmodel.dart';

class NotepadScreen extends StatelessWidget {
  const NotepadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotepadViewmodel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Add Note",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                value.isEdit
                    ? value.updateNote(value.editingDocId!)
                    : value.addNote();

                Get.to(Notehome());
              },
              icon: const Icon(Icons.save, color: Colors.black, size: 30),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                controller: value.titlecontroller,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),

                  filled: true,
                ),
              ),

              TextFormField(
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                controller: value.descriptioncontroller,
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Description.......",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
