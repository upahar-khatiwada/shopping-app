import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/login_components/login_screens/email_verification_page.dart';
import 'package:shopping_app/login_components/login_screens/login_screens_constants/const_var.dart';
import 'package:shopping_app/login_components/login_screens/sign_up_helper_methods/display_error_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController signUpEmailController;
  late final TextEditingController signUpPasswordController;
  late final TextEditingController signUpPasswordConfirmController;

  bool isObscureTextPassword = true; // for first password field
  bool isObscureTextPasswordConfirm = true; // for password confirmation field

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpEmailController = TextEditingController();
    signUpPasswordController = TextEditingController();
    signUpPasswordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpPasswordConfirmController.dispose();
    super.dispose();
  }

  // function to sign up with email and password
  void signUp() async {
    if (signUpEmailController.text.trim().isEmpty ||
        signUpPasswordController.text.trim().isEmpty ||
        signUpPasswordConfirmController.text.trim().isEmpty) {
      if (mounted) {
        displayErrorMessage(
          'Please fill out the respective fields!',
          'Error',
          context,
        );
      }
      return;
    }

    if (signUpPasswordController.text != signUpPasswordConfirmController.text) {
      if (mounted) {
        displayErrorMessage("Passwords don't match", 'Error', context);
      }
      return;
    }

    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: circularProgressIndicatorColor,
            ),
          );
        },
      );
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: signUpEmailController.text.trim(),
            password: signUpPasswordController.text.trim(),
          );

      // sending a verification email
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
      }

      if (mounted) {
        Navigator.pop(context);

        displayErrorMessage(
          'Verification email sent, Check your inbox!',
          'Check Inbox',
          context,
        );

        // pushing the email verification screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const EmailVerificationPage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context);
        displayErrorMessage(e.code, 'Error', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: Colors.black)),
      body: Center(
        child: SingleChildScrollView(
          child: IntrinsicWidth(
            stepWidth: 600,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 300,
                  height: 200,
                  child: Image.asset(
                    'assets/sign_up.webp',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 15),
                // for email field
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
                      hintText: 'E-mail',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon: const Icon(Icons.mail, color: Colors.black),
                      filled: true,
                      fillColor: fillColor,
                    ),
                    style: const TextStyle(color: Colors.black),
                    controller: signUpEmailController,
                    cursorErrorColor: Colors.red,
                    cursorColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // first password field
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
                      filled: true,
                      fillColor: fillColor,
                      alignLabelWithHint: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscureTextPassword = !isObscureTextPassword;
                          });
                        },
                        icon: isObscureTextPassword
                            ? const Icon(Icons.visibility, color: Colors.black)
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    obscureText: isObscureTextPassword,
                    controller: signUpPasswordController,
                    cursorErrorColor: Colors.red,
                    cursorColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // for password confirmation field
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
                      filled: true,
                      fillColor: fillColor,
                      alignLabelWithHint: true,
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon: const Icon(
                        Icons.password_sharp,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscureTextPasswordConfirm =
                                !isObscureTextPasswordConfirm;
                          });
                        },
                        icon: isObscureTextPasswordConfirm
                            ? const Icon(Icons.visibility, color: Colors.black)
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    obscureText: isObscureTextPasswordConfirm,
                    controller: signUpPasswordConfirmController,
                    cursorErrorColor: Colors.red,
                    cursorColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: signUp,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: loginButtonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: signUpTextColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[800],
                        letterSpacing: 0.5,
                        fontSize: 17,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login Now!',
                          style: TextStyle(
                            color: Colors.red,
                            letterSpacing: 1.0,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
