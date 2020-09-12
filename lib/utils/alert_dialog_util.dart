import 'package:flutter/material.dart';

Future<void> alertDialogBuilder(
    BuildContext context, String title, String message, Function onPressed) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
                onPressed: () {
                  onPressed();
                },
                child: Text('CLOSE'))
          ],
        );
      });
}
