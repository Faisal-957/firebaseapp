import 'package:cloud_firestore/cloud_firestore.dart';

class DbServices {
  //-----instance-------//
  final CollectionReference firestore = FirebaseFirestore.instance.collection(
    "Curdop",
  );

  //-----create-------//
  Future<void> createData(String name, String age, String address) {
    return firestore.add({'Name': name, 'Age': age, 'Address': address});
  }

  //-----Read-------//
  Stream<QuerySnapshot> readData() {
    return firestore.snapshots();
  }

  //-----update-------//

  //-----delet-------//
}
