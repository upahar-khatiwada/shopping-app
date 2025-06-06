import 'package:flutter/material.dart';

class BottomAppBarItems extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const BottomAppBarItems({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: Theme.of(context).colorScheme.inversePrimary),
    );
  }
}
