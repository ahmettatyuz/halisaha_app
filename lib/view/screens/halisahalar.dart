import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Halisahalar extends ConsumerStatefulWidget {
  const Halisahalar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HalisahalarState();
}

class _HalisahalarState extends ConsumerState<Halisahalar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Halısahalar ekranı"),
    );
  }
}