import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Rezervasyonlar extends ConsumerStatefulWidget {
  const Rezervasyonlar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RezervasyonlarState();
}

class _RezervasyonlarState extends ConsumerState<Rezervasyonlar> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Rezervasyonlar ekranı",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
      ),
    );
  }
}