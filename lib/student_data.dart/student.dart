import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:widgets_practicing/student_data.dart/studentdetails.dart';
import 'package:widgets_practicing/student_data.dart/student_viewmodel.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentViewsModel>(
      builder: (context, val, child) => Scaffold(
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
                controller: val.nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              10.verticalSpace,

              TextField(
                controller: val.rollNoController,
                decoration: InputDecoration(labelText: "Roll No"),
              ),
              10.verticalSpace,

              TextField(
                controller: val.classController,
                decoration: InputDecoration(labelText: "Class"),
              ),
              10.verticalSpace,

              TextField(
                controller: val.ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Age"),
              ),
              20.verticalSpace,
              Center(
                child: SizedBox(
                  height: 50.h,
                  width: 200.w,
                  child: ElevatedButton(
                    onPressed: () {
                      final val = Provider.of<StudentViewsModel>(
                        context,
                        listen: false,
                      );

                      if (val.isEditing) {
                        val.updateData(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentDetails(),
                          ),
                        );
                      } else {
                        val.submitData(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentDetails(),
                          ),
                        );
                      }
                    },

                    child: Text(val.isEditing ? "Update" : "Submit"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
