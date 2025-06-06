import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/home_page.dart';
import 'package:shopping_app/login_components/login_screens/email_verification_page.dart';
import 'package:shopping_app/login_components/login_screens/login_page.dart';
import 'package:shopping_app/login_components/login_screens/login_screens_constants/const_var.dart';
// import 'package:logger/logger.dart';

// final Logger logger = Logger();

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // listens to the auth changes
        // and navigates the app accordingly
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: circularProgressIndicatorColor,
              ),
            );
          } else if (snapshot.hasData) {
            final User user = snapshot.data!;
            final List<String> providers = user.providerData
                .map((UserInfo p) => p.providerId)
                .toList();

            // logger.i(providers);

            // checking for sign up method
            if (providers.contains('password') && !user.emailVerified) {
              return const EmailVerificationPage();
            }
            return const HomePage(); // if login was successful returns home page
          } else {
            return const LoginScreen(); // else back to login screen
          }
        },
      ),
    );
  }
}
