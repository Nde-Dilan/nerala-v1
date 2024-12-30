import 'package:flutter/material.dart';

void showGoogleSignInDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Use Google Sign-In'),
        content: Text('Facebook authentication requires too much configuration. Please use Google Sign-In instead.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}