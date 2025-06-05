import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/login_screens/auth_page.dart';
import 'package:shopping_app/Screens/login_screens/login_screens_constants/const_var.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = FirebaseAuth.instance.currentUser!;

  void signOut() async {
    await FirebaseAuth.instance.signOut();

    // ensures the logout
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const AuthPage(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(color: textColor)),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Email: ${user.email}',
              style: TextStyle(color: textColor, fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text(
              'Display Name: ${user.displayName}',
              style: TextStyle(color: textColor, fontSize: 30),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: signOut,
              label: Text('Sign Out!', style: TextStyle(color: textColor)),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
