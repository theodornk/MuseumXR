import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_museum/functions/firebase_auth.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => AuthorizationPageState();
}

class AuthorizationPageState extends State<AuthorizationPage> {
  static final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  var _passwordController = TextEditingController();
  var _emailController = TextEditingController();
  String errorMessage = '';

  loginUser(email, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        width: 300,
        child: Form(
          key: _loginKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {},
                  controller: _emailController,
                  cursorColor: Colors.cyan,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      prefixIcon: Icon(Icons.email),
                      labelText: 'E-post',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "E-post",
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {},
                  controller: _passwordController,
                  cursorColor: Colors.cyan,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Passord',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Passord",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(errorMessage),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      loginUser(
                          _emailController.text, _passwordController.text);
                    },
                    child: Text('Login')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
