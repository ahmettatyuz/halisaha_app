import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/models/team.dart';

class TakimDetay extends ConsumerStatefulWidget {
  const TakimDetay({super.key, required this.team});
  final Team team;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TakimDetayState();
}

class _TakimDetayState extends ConsumerState<TakimDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.team.name!,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: Center(
        child: Text(widget.team.name!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Oyuncu Ekle"),
        icon: const Icon(Icons.add),
        onPressed: (){
          Navigator.popUntil(context, (route) => route.isFirst);
          ref.read(screenProvider.notifier).setScreen("oyuncular");
        },
      ),
    );
  }
}
