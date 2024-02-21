import 'package:andrianiaiina_quote/widgets/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection'),
        elevation: 1,
      ),
      body: Column(children: [
        Form(
            child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  label: Text(
                "Email",
                style: TextStyle(color: Colors.black54),
              )),
              controller: _email,
            ),
            TextField(
              decoration: const InputDecoration(
                  label: Text("Mot de passe",
                      style: TextStyle(color: Colors.black54))),
              controller: _password,
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: _email.text, password: _password.text);
                  if (FirebaseAuth.instance.currentUser != null) {
                    context.go('/');
                  }
                } catch (e) {
                  showMessage(context,
                      "Une erreur s'est produite, verifiez votre connexion");
                }
              },
              child: const Text("Se connecter"),
            ),
          ],
        )),
        TextButton(
            onPressed: () {
              context.go('/register');
            },
            child: const Text('Créer un compte'))
      ]),
    );
  }
}
