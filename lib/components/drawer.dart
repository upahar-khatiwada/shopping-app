import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/drawer_items.dart';
import 'package:shopping_app/pages/settings_page.dart';

import '../login_components/login_screens/auth_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 60),
          Text(
            'MENU',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              letterSpacing: 5.0,
              fontSize: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Divider(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          DrawerItems(
            text: 'Home',
            icon: Icons.home,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerItems(
            text: 'Settings',
            icon: Icons.settings,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) => const SettingsPage(),
                ),
              );
            },
          ),
          DrawerItems(
            text: 'Log Out',
            icon: Icons.logout,
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              if (context.mounted) {
                // ensures the logout
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) => const AuthPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
