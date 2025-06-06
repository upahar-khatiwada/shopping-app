import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/login_components/login_screens/forgot_password_page.dart';
import 'package:shopping_app/login_components/login_screens/login_screens_constants/const_var.dart';
import 'package:shopping_app/login_components/login_screens/sign_up_helper_methods/sign_up_with_facebook.dart';
import 'package:shopping_app/login_components/login_screens/sign_up_helper_methods/sign_up_with_google.dart';
import 'package:shopping_app/login_components/login_screens/sign_up_helper_methods/sign_up_with_twitter.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/login_components/login_screens/sign_up_helper_methods/display_error_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController; // controller for email
  late final TextEditingController
  passwordController; // controller for password
  bool isObscureText = true; // for viewing the password

  // initializing the controllers
  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  // disposing the controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  // function to sign in using email
  void signIn() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      displayErrorMessage(
        'Please fill out the respective fields!',
        'Error',
        context,
      );
      return;
    }

    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: circularProgressIndicatorColor,
            ),
          );
        },
        useRootNavigator: false,
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        displayErrorMessage(e.code, 'Error', context);
        // logger.e(e.message);
      }
    } finally {
      navigatorKey.currentState?.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: IntrinsicWidth(
            stepWidth: 600,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 30),
                SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.asset(
                    'assets/default_profile.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Sign In!',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                    letterSpacing: 3.0,
                  ),
                ),
                const SizedBox(height: 25),
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
                    controller: emailController,
                    cursorErrorColor: Colors.red,
                    cursorColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
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
                            isObscureText = !isObscureText;
                          });
                        },
                        icon: isObscureText
                            ? const Icon(Icons.visibility, color: Colors.black)
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    obscureText: isObscureText,
                    controller: passwordController,
                    enableSuggestions: false,
                    autofocus: false,
                    cursorErrorColor: Colors.red,
                    cursorColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) =>
                                const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: textColor, letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: signIn,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: loginButtonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: signInTextColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(color: dividerColor, thickness: 1.1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'or continue with',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: dividerColor,
                          indent: 3,
                          endIndent: 3,
                          thickness: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    LoginWith(
                      assetLocation: 'assets/x.png',
                      onTap: () {
                        signInWithTwitter(context);
                      },
                    ),
                    LoginWith(
                      assetLocation: 'assets/facebook1.webp',
                      onTap: () {
                        signInWithFacebook(context);
                      },
                    ),
                    LoginWith(
                      assetLocation: 'assets/google.webp',
                      onTap: () {
                        signInWithGoogle(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Not a member yet?',
                      style: TextStyle(
                        color: Colors.grey[800],
                        letterSpacing: 0.5,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Register Now!',
                        style: TextStyle(
                          color: Colors.red,
                          letterSpacing: 1.0,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.visible,
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

class LoginWith extends StatelessWidget {
  final String assetLocation;
  final VoidCallback onTap;
  const LoginWith({
    super.key,
    required this.assetLocation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: 75,
          height: 70,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(assetLocation, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
