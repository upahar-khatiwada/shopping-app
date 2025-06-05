import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/login_screens/auth_page.dart';
import 'package:shopping_app/Screens/login_screens/email_verification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/Screens/login_screens/login_screens_constants/const_var.dart';
import 'package:shopping_app/Screens/login_screens/sign_up_page.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const AuthPage(),
        // '/login': (BuildContext context) => const LoginScreen(),
        '/signup': (BuildContext context) => const SignUpScreen(),
        '/verification': (BuildContext context) =>
            const EmailVerificationPage(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        appBarTheme: const AppBarTheme(color: bgColor, elevation: 0),
        splashColor: splashColor,
      ),
    );
  }
}
