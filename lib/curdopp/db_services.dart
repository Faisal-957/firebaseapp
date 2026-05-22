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
  Future<void> updateData(String id, String name, String age, String address) {
    return firestore.doc(id).update({
      'Name': name,
      'Age': age,
      'Address': address,
    });
  }

  //-----delet-------//
  Future<void> deleteData(String id) {
    return firestore.doc(id).delete();
  }
}
