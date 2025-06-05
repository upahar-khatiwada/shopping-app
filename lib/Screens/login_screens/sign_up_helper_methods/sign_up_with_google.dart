import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/Screens/login_screens/login_screens_constants/const_var.dart';
import 'package:shopping_app/Screens/login_screens/sign_up_helper_methods/display_error_message.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';

// function to sign in using a google account
Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
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
      useRootNavigator: false, // tells flutter to use closest navigator
      // in the widget tree relative to given context
    );

    final GoogleSignIn googleSignIn = GoogleSignIn();

    // signing out of accounts if there is any
    await googleSignIn.signOut();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      displayErrorMessage(e.code, 'Error', context);
    }
    // logger.e(e.code);
  } finally {
    navigatorKey.currentState?.pop();
  }
  return null;
}
