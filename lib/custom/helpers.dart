import 'package:flutter/material.dart';

void messageBox(BuildContext context,String title,String message,String button) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
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
