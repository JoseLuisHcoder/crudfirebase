import 'package:crudfirebase/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Users'),
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
                  await addUser(firstNameController.text,
                      lastNameController.text, emailController.text);
                  Navigator.pop(context);
                },
                child: Text("Guardar"))
          ],
        ),
      ),
    );
  }
}
