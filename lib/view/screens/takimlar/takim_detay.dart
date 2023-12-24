import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/view/widgets/oyuncular/oyuncu_card.dart';

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
        child: Column(
          children: [
            Image.asset(
              "assets/icons/shield.png",
              scale: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Takım Kadrosu",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return PlayerCard(player: widget.team.players![index]);
                },
                itemCount: widget.team.players!.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Oyuncu Ekle"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
          ref.read(screenProvider.notifier).setScreen("oyuncular");
        },
      ),
    );
  }
}
