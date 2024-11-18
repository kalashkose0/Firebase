import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasemain_1/repository/widgets/UiHelper.dart';
import 'package:flutter/material.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(
              controller: emailcontroller,
              text: "Enter email",
              iconData: Icons.email_outlined),
          UiHelper.CustomTextField(
              controller: passwordcontroller,
              text: "Enter Paswword",
              iconData: Icons.lock_open),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                signup(
                    email: emailcontroller.text.toString(),
                    password: passwordcontroller.text.toString());
              },
              child: Text("Sign up"))
        ],
      ),
    );
  }

  signup({required String email, required String password}) async {
    if (email == "" || password == "") {
      return UiHelper.CustomSnackBar(
          text: "Enter email or password", context: context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          // log("User created $value");
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomSnackBar(
            text: ex.code.toString(), context: context);
      }
    }
  }
}
