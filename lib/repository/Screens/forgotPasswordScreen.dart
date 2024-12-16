import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasemain_1/repository/widgets/UiHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class forgotPasswordScreen extends StatefulWidget {
  const forgotPasswordScreen({super.key});

  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen> {
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(
              controller: emailcontroller,
              text: "Enter Email",
              iconData: Icons.mail),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                forgot(email: emailcontroller.text.toString());
              },
              child: Text("Send Mail"))
        ],
      ),
    );
  }

  forgot({required String email}) async {
    if (email == "") {
      return UiHelper.CustomSnackBar(text: "Enter Email", context: context);
    } else {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        UiHelper.CustomSnackBar(
            text: "OTP sent Please check ", context: context);
      });
    }
  }
}
