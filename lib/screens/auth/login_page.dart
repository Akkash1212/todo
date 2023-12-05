import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todo/common_widgets/login_textField.dart';
import 'package:todo/constant/my_firebase_exceptions.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constant/ak_colors.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool emailValue = true;

  bool passwordValue = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AKColors.kMainColor,
                radius: 70,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              LoginTextField(
                controller: emailController,
                label: 'Email',
                hintText: 'Enter a Email Id',
                isError: !emailValue,
                onchange: (value) {
                  emailValue = true;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),
              LoginTextField(
                controller: passwordController,
                label: "Password",
                hintText: 'Enter a Password',
                isError: !passwordValue,
                onchange: (value) {
                  passwordValue = true;
                  setState(() {});
                },
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
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AKColors.kMainColor),
                      ),
                      onPressed: () async {
                        final auth = FirebaseAuth.instance;
                        try {
                          await auth.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                          print(e.code);
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (e.code == MyFirebaseException.invalidEmail) {
                            emailValue = false;
                            setState(() {});
                          }
                          if (e.code == MyFirebaseException.weakPassword) {
                            passwordValue = false;
                          }
                          if (e.code == MyFirebaseException.emailExist) {
                            VxToast.show(context, msg: 'Email Exist Alredy');
                          }
                        }
                        // emailController.clear();
                        // passwordController.clear();
                      },
                      child: Text(
                        'signup',
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AKColors.kMainColor),
                      ),
                      onPressed: () async {
                        final auth = FirebaseAuth.instance;
                        try {
                          await auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                          print(e.code);
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (e.code == MyFirebaseException.invalidEmail) {
                            emailValue = false;
                            setState(() {});
                          }
                          if (e.code == MyFirebaseException.weakPassword) {
                            passwordValue = false;
                            setState(() {});
                          }
                          if (e.code == MyFirebaseException.invalidCredential) {
                            VxToast.show(context,
                                msg:
                                    '${MyFirebaseException.invalidCredential}Either Email or Password ');
                          }
                        }
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: Text(
                        'Login',
                      )),
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
