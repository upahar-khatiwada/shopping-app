import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shopping_app/currency/currency_provider.dart';
import 'package:shopping_app/login_components/login_screens/auth_page.dart';
import 'package:shopping_app/login_components/login_screens/email_verification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/login_components/login_screens/sign_up_page.dart';
import 'package:shopping_app/themes/theme_provider.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  await Hive.openBox('shopping_theme');
  await Hive.openBox('currency_box');
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<ThemeProvider>(
          create: (BuildContext context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<CartModel>(
          create: (BuildContext context) => CartModel(),
        ),
        ChangeNotifierProvider<CurrencyProvider>(
          create: (BuildContext context) => CurrencyProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const AuthPage(),
        '/signup': (BuildContext context) => const SignUpScreen(),
        '/verification': (BuildContext context) =>
            const EmailVerificationPage(),
      },
    );
  }
}
