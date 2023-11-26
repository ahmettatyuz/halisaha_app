import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/session_provider.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/view/widgets/add_session.dart';
import 'package:halisaha_app/view/widgets/session_card.dart';

class SessionEdit extends ConsumerStatefulWidget {
  const SessionEdit({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SessionEditState();
}

class _SessionEditState extends ConsumerState<SessionEdit> {
  bool state = true;
  void sessionModal() {
    showModalBottomSheet<void>(
      useSafeArea: true,
      context: context,
      builder: (ctx) => AddSession(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Session> sessions = ref.watch(sessionsProvider);
    Widget activeScreen = Center(
      child: Text(
        "Hiç seans yok !",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
    if (sessions.isNotEmpty && sessions[0].id != null) {
      activeScreen = ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: sessions.length,
        itemBuilder: (BuildContext context, int index) {
          Session session = sessions[index];
          if (session.id != null) {
            return SessionCard(
              id: session.id!,
              time: session.sessionTime!,
              index: index,
            );
          }
          return null;
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Seanslarım",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: activeScreen,
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          sessionModal();
        },
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconSize: 35,
          foregroundColor: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
