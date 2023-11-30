import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'Enter a Email Id'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password', hintText: 'Enter a Password'),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final auth = FirebaseAuth.instance;
                        try {
                          await auth.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                        }
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: Text('signup')),
                  ElevatedButton(
                      onPressed: () async {
                        final auth = FirebaseAuth.instance;
                        try {
                          await auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                        }
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: Text('Login')),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
