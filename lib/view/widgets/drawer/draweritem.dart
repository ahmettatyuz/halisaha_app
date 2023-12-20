import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerItem extends ConsumerWidget {
  const DrawerItem({super.key,required this.onClick,required this.text,this.iconData});
  final String text;
  final void Function() onClick;
  final IconData? iconData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
        title: Text(text),
        onTap: (){
          Navigator.pop(context);
          onClick();
        },
        leading: Icon(iconData),
      );
  }
}