import 'package:crudfirebase/pages/users/add_users.dart';
import 'package:crudfirebase/pages/users/edit_users.dart';
import 'package:crudfirebase/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data?[index]['first_name']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // Confirmar antes de borrar
                          bool? confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Confirmar eliminación"),
                              content: Text(
                                  "¿Estás seguro de que deseas eliminar este usuario?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text("Eliminar"),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            // Obtener UID del usuario
                            String uid = snapshot.data?[index]['uid'];

                            // Llamar la función para borrar
                            await deleteUser(uid);

                            // Actualizar la lista después de borrar
                            setState(() {});
                          }
                        },
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditUsers(
                                  first_name: snapshot.data?[index]
                                      ['first_name'],
                                  last_name: snapshot.data?[index]['last_name'],
                                  email: snapshot.data?[index]['email'],
                                  uid: snapshot.data?[index]['uid'])),
                        );
                        setState(() {});
                      },
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddUsers()));
            setState(() {});
          },
          child: Icon(Icons.add)),
    );
  }
}
