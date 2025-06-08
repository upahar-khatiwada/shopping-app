import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/login_components/login_screens/login_screens_constants/const_var.dart';
import 'package:shopping_app/login_components/login_screens/sign_up_helper_methods/display_error_message.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<ForgotPasswordPage> {
  late final TextEditingController forgotEmailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forgotEmailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    forgotEmailController.dispose();
    super.dispose();
  }

  // function to reset the password
  void resetPassword() async {
    if (forgotEmailController.text.trim().isEmpty) {
      displayErrorMessage("Text Field can't be empty", 'Error', context);
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgotEmailController.text.trim(),
      );

      if (mounted) {
        displayErrorMessage(
          'Reset password Link Sent!',
          'Check Inbox!',
          context,
        );
        Navigator.pop(context); // to send the user back to login screen
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        displayErrorMessage('Error: ${e.code}', 'Error', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        child: IntrinsicWidth(
          stepWidth: 600,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 400,
                  width: 350,
                  child: Image.asset('assets/login_assets/forgot.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: borderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: emailAndPasswordOutlineColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter your e-mail',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon: const Icon(Icons.mail, color: Colors.black),
                      filled: true,
                      fillColor: fillColor,
                    ),
                    style: const TextStyle(color: Colors.black),
                    controller: forgotEmailController,
                    cursorErrorColor: Colors.red,
                    cursorColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: resetPassword,
                      child: Container(
                        width: 600,
                        height: 60,
                        decoration: BoxDecoration(
                          color: loginButtonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                              color: forgotPasswordTextColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
