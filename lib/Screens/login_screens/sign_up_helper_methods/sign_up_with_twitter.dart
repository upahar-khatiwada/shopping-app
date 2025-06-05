import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/Screens/login_screens/login_screens_constants/const_var.dart';
import 'package:shopping_app/Screens/login_screens/sign_up_helper_methods/display_error_message.dart';

// function to sign in using twitter
Future<OAuthCredential?> signInWithTwitter(BuildContext context) async {
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

    // setting up twitter login with necessary api keys and secret
    final TwitterLogin twitterLogin = TwitterLogin(
      apiKey: dotenv.env['TWITTER_APIKEY']!,
      apiSecretKey: dotenv.env['TWITTER_SECRET']!,
      redirectURI: dotenv.env['TWITTER_CALLBACK']!,
    );

    final AuthResult authResult = await twitterLogin.login();

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final OAuthCredential twitterAuthCredential =
            TwitterAuthProvider.credential(
              accessToken: authResult.authToken!,
              secret: authResult.authTokenSecret!,
            );

        await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);

        // logger.i(
        //   'Logged In: ${authResult.authToken}, ${authResult.authTokenSecret}',
        // );
        return twitterAuthCredential;

      case TwitterLoginStatus.cancelledByUser:
        if (context.mounted) {
          displayErrorMessage('Cancelled by User', 'Error', context);
        }
        break;

      case TwitterLoginStatus.error:
        if (context.mounted) {
          displayErrorMessage(
            'Error: ${authResult.errorMessage}',
            'Error',
            context,
          );
        }
        // logger.e('Error: ${authResult.errorMessage}');
        break;

      case null:
        if (context.mounted) {
          displayErrorMessage('Null Result', 'Error', context);
        }
        // logger.e('Null Result');
        break;
    }
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
