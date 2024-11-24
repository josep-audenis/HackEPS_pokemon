import 'package:flutter/material.dart';
import 'package:lspokedex/models/tournament.dart';

class TournamentWidget extends StatelessWidget {
  final Tournament tournament;

  const TournamentWidget({Key? key, required this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${tournament.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
            if (tournament.time != null) Text('Time: ${tournament.time}'),
            Text('Can Register: ${tournament.canRegister ? "Yes" : "No"}'),
            Text('Winner: ${tournament.winner ?? "TBD"}'),
          ],
        ),
      ),
    );
  }
}
