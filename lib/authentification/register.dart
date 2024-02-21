import 'package:andrianiaiina_quote/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
        elevation: 1,
      ),
      body: Column(children: [
        TextField(
          decoration: const InputDecoration(label: Text("Email")),
          controller: _email,
        ),
        TextField(
          decoration: const InputDecoration(label: Text("Mot de passe")),
          controller: _password,
        ),
        TextButton(
          onPressed: () async {
            try {
              await _auth.createUserWithEmailAndPassword(
                  email: _email.text, password: _password.text);
              if (FirebaseAuth.instance.currentUser != null) {
                context.go('/');
              }
            } catch (e) {
              showMessage(context, "une erreur s'est produite");
            }
          },
          child: const Text("s'inscrire"),
        )
      ]),
    );
  }
}
