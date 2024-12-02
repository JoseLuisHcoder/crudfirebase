import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
//. Leer base  de datos
Future<List<Map<String, dynamic>>> getUsers() async {
  List<Map<String, dynamic>> users = [];
  CollectionReference usersRef = db.collection('users');

  QuerySnapshot queryUsers = await usersRef.get();

//.Se comento este codigo ya qu eno proporcionaba el UID del usuario, el cual se necesita para actializar la info del usuario
  // queryUsers.docs.forEach((documento) {
  //   users.add(documento.data() as Map<String, dynamic>);
  // });
  for (var doc in queryUsers.docs) {
    Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
    userData['uid'] = doc.id; // Agregar el UID al mapa
    users.add(userData);
  }
  print({"users": users});
  return users;
}

//. Agregar nuevos usuarios
Future<void> addUser(String first_name, String last_name, String email) async {
  await db
      .collection('users')
      .add({"first_name": first_name, "last_name": last_name, "email": email});
}

//. Actualizar usuarios
Future<void> updateUser(
    String uid, String first_name, String last_name, String email) async {
  await db.collection('users').doc(uid).update({
    "first_name": first_name,
    "last_name": last_name,
    "email": email,
  });
}

//. Borrar usuario
Future<void> deleteUser(String uid) async {
  try {
    await db.collection('users').doc(uid).delete();
    print("Usuario con UID $uid eliminado exitosamente.");
  } catch (e) {
    print("Error al eliminar el usuario: $e");
  }
}
