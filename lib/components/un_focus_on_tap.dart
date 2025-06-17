import 'package:flutter/material.dart';

void unFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class UnFocusOnTap extends StatelessWidget {
  const UnFocusOnTap({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: unFocus, child: child);
  }
}
