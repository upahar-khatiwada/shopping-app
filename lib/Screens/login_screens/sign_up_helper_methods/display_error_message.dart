import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/login_screens/login_screens_constants/const_var.dart';

void displayErrorMessage(String message, String error, BuildContext context) {
  // this schedules a callback to run after current frame is done rendering
  // once building is finished and laying out the current UI, then only this runs
  // it avoids showing dialog while widget tree is still building
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(error),
            content: Text(message, style: TextStyle(color: textColor)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
        useRootNavigator: true, // ensures it works from nested navigators
      );
    }
  });
}
