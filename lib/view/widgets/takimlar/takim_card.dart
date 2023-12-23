import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/view/screens/takimlar/takim_detay.dart';

class TakimCard extends ConsumerWidget {
  const TakimCard({super.key, required this.team});
  final Team team;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>TakimDetay(team: team)));
        },
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,5),
                child: Image.asset(
                  "assets/icons/shield.png",
                  scale: 6,
                ),
              ),
              Column(
                children: [
                  Text(
                    team.name!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                            width:
                                5), // İcon ile metin arasına biraz boşluk ekledik
                        Flexible(
                          child: Text(
                            "${team.players!.length.toString()} oyuncu",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
