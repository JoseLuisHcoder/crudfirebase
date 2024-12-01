import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getUsers() async {
  List<Map<String, dynamic>> users = [];
  CollectionReference usersRef = db.collection('users');

  QuerySnapshot queryUsers = await usersRef.get();

  queryUsers.docs.forEach((documento) {
    users.add(documento.data() as Map<String, dynamic>);
  });
  print({"users": users});
  return users;
}

Future<void> addUser(String first_name, String last_name, String email) async {
  await db
      .collection('users')
      .add({"first_name": first_name, "last_name": last_name, "email": email});
}
