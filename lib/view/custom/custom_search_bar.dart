import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar(
      {super.key,
      this.controller,
      this.hint,
      this.textChanged,
      this.filterFunction});
  final TextEditingController? controller;
  final String? hint;
  final void Function(String text)? textChanged;
  final void Function()? filterFunction;
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: hint,
      leading: const Icon(Icons.search),
      onChanged: textChanged,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 50, minHeight: 50),
      // shape: MaterialStateProperty.all(LinearBorder.none),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      trailing: [
        filterFunction != null
            ? IconButton(
                onPressed: filterFunction, icon: const Icon(Icons.filter_alt))
            : Container()
      ],
    );
  }
}
