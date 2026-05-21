import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets_practicing/curdopp/db_services.dart';

class Curdop extends StatelessWidget {
  const Curdop({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          children: [
            Text(
              "Curd Operation",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            30.verticalSpace,
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            20.verticalSpace,
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            20.verticalSpace,
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            20.verticalSpace,
            ElevatedButton(
              onPressed: () {
                DbServices().createData(
                  nameController.text,
                  ageController.text,
                  addressController.text,
                );
                print("Data added successfully");
              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
