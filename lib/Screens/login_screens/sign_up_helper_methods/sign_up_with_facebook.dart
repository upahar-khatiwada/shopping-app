import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/Screens/login_screens/sign_up_helper_methods/display_error_message.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/Screens/login_screens/login_screens_constants/const_var.dart';

// Function to sign in with facebook
Future<UserCredential?> signInWithFacebook(BuildContext context) async {
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
      useRootNavigator: false,
    );

    // logging out of facebook account just in case if previously some facebook account was logged in
    await FacebookAuth.instance.logOut();
    // final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
    // logger.i('Access token after logout: $accessToken'); // should print null

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: <String>[
        'public_profile',
      ], // add 'email' in the list for getting the email
      // had to remove 'email' from now as facebook isn't allowing to do so
      loginBehavior: LoginBehavior.dialogOnly,
      loginTracking: LoginTracking.enabled,
    );

    // check if login was successful
    if (loginResult.status == LoginStatus.success &&
        loginResult.accessToken != null) {
      // create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // sign in with the credential
      return await FirebaseAuth.instance.signInWithCredential(
        facebookAuthCredential,
      );
    }
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      displayErrorMessage(e.code, 'Error', context);
    }
    // logger.e(e.code);
  } finally {
    // global navigator's key
    navigatorKey.currentState?.pop();
  }
  return null;
}
