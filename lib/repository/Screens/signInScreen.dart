import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasemain_1/repository/Screens/forgotPasswordScreen.dart';
import 'package:firebasemain_1/repository/widgets/UiHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(
              controller: emailcontroller,
              text: "Enter Email",
              iconData: Icons.mail),
          UiHelper.CustomTextField(
              controller: passwordcontroller,
              text: "Enter Password",
              iconData: Icons.lock),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => forgotPasswordScreen()));
                  },
                  child: Text("Forgot password"))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                signIn(
                    email: emailcontroller.text.toString(),
                    password: passwordcontroller.text.toString());
              },
              child: Text("SignIn"))
        ],
      ),
    );
  }

  signIn({required String email, required String password}) async {
    if (email == "" || password == "") {
      return UiHelper.CustomSnackBar(
          text: "Enter email & password", context: context);
    } else {
      UserCredential? Usercredential;
      try {
        Usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          return UiHelper.CustomSnackBar(
              text: value.user!.email.toString(), context: context);
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomSnackBar(
            text: ex.code.toString(), context: context);
      }
    }
  }
}
