import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Future<void> messageBox(
    BuildContext context, String title, String message, String button) async {
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

void toast(context,title,description, ToastificationType type, int duration,IconData icon) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: Duration(seconds: duration),
    title: title,
    description: description,
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    // animationBuilder: (context, animation, alignment, child) {
    //   return FadeTransition(
    //     // turns: animation,
    //     opacity: ,
    //     child: child,
    //   );
    // },
    icon: Icon(icon,color: Theme.of(context).colorScheme.secondary,),
    primaryColor: Theme.of(context).colorScheme.primary,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    callbacks: ToastificationCallbacks(
      onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
      onCloseButtonTap: (toastItem) =>
          print('Toast ${toastItem.id} close button tapped'),
      onAutoCompleteCompleted: (toastItem) =>
          print('Toast ${toastItem.id} auto complete completed'),
      onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
    ),
  );
}
