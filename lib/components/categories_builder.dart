import 'package:flutter/material.dart';

class CategoriesBuilder extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const CategoriesBuilder({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
