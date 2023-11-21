import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({super.key, required this.time, required this.id});
  final String time;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.green.shade100,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Seans Saati: $time",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.green,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
