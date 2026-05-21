import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:widgets_practicing/curdopp/db_services.dart';

class Readscreen extends StatelessWidget {
  const Readscreen({super.key});
  //steps to show data in listview
  // 0 creat function to read data from firebase in db_services.dart
  // 1 condition for read data
  // 2 show data in listview
  // 3 listview.builder
  // 4 store each doc
  // 5 save id of each doc
  // 6 convert to map
  // 7 convert  map to variable (optional)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: DbServices().readData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List Dataa = snapshot.data!.docs;
            return ListView.builder(
              itemCount: Dataa.length,
              itemBuilder: (context, index) {
                DocumentSnapshot eachdoc = Dataa[index];
                String id = eachdoc.id;
                Map<String, dynamic> map =
                    eachdoc.data() as Map<String, dynamic>;
                String Name = map["Name"].toString();
                String Age = map["Age"].toString();
                String Address = map["Address"].toString();
                return Card(
                  child: ListTile(
                    leading: Column(
                      children: [
                        Text(
                          Name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Age,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Address,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
