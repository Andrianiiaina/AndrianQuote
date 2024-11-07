import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_service.dart';
import 'package:andrianiaiina_quote/widgets/widget.dart';
import 'package:go_router/go_router.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isSignUpMode = false;
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      User? user;
      if (isSignUpMode) {
        user = await _authService.register(_email.text, _password.text);
      } else {
        user = await _authService.signIn(_email.text, _password.text);
      }
      if (user != null) {
        context.go('/');
      } else {
        showMessage(
            context, "Une erreur s'est produite, verifiez votre connexion");
      }
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isSignUpMode ? "Inscription" : "Connexion"),
          elevation: 1,
        ),
        body: Form(
          key: _formKey,
          child: Column(children: [
            TextField(
              decoration: const InputDecoration(label: Text("Email")),
              controller: _email,
            ),
            TextField(
              decoration: const InputDecoration(label: Text("Mot de passe")),
              controller: _password,
            ),
            TextButton(
              onPressed: _submit,
              child: Text(isSignUpMode ? "s'inscrire" : "se connecter"),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isSignUpMode ? "Déja un compte?" : "Pas de compte?"),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isSignUpMode = !isSignUpMode;
                      });
                    },
                    child: Text(isSignUpMode ? "se connecter" : "s'inscrire"))
              ],
            ),
          ]),
        ));
  }
}
