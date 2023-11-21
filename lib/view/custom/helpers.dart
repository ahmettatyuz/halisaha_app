import 'package:flutter/material.dart';
Future<void> messageBox(BuildContext context, String title, String message, String button) async {
  await showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(button),
          )
        ],
      );
    },
  );
}
