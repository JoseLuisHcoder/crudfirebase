import 'package:crudfirebase/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditUsers extends StatefulWidget {
  final String first_name;
  final String last_name;
  final String email;
  final String uid;

  const EditUsers(
      {super.key,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.uid});

  @override
  State<EditUsers> createState() => _EditUsersState();
}

class _EditUsersState extends State<EditUsers> {
  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    firstNameController.text = widget.first_name;
    lastNameController.text = widget.last_name;
    emailController.text = widget.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                hintText: "Ingrese su nombre",
              ),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                hintText: "Ingrese su apellido",
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Ingrese su correo",
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await updateUser(widget.uid, firstNameController.text,
                      lastNameController.text, emailController.text);
                  Navigator.pop(context);
                },
                child: Text("Actualizar"))
          ],
        ),
      ),
    );
  }
}
