import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';

Logger _log = Logger('error_dialog.dart');


void showErrorDialog(BuildContext context, String title, String error) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          textAlign: TextAlign.center,
          title,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                error,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: seedColor),
            ),
          )
        ],
      );
    },
  );
}

