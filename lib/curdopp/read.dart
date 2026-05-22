import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:widgets_practicing/curdopp/creat.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Curdop()),
          );
        },
        child: Icon(Icons.add),
      ),

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
                  color: Colors.grey[100],
                  child: ListTile(
                    title: Text(Name),
                    subtitle: Text("Age: $Age, Address: $Address"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            DbServices().deleteData(id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            _showUpdateDialog(context, id, Name, Age, Address);
                          },

                          icon: Icon(Icons.edit),
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

void _showUpdateDialog(
  BuildContext context,
  String id,
  String name,
  String age,
  String address,
) {
  TextEditingController nameController = TextEditingController(text: name);
  TextEditingController ageController = TextEditingController(text: age);
  TextEditingController addressController = TextEditingController(
    text: address,
  );

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Update Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              DbServices().updateData(
                id,
                nameController.text,
                ageController.text,
                addressController.text,
              );
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}
