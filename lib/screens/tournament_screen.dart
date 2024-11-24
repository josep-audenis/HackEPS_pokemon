import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tournament_provider.dart';

class TournamentScreen extends StatefulWidget {
  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<TournamentProvider>(context, listen: false).fetchTournaments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tournaments'),
        backgroundColor: Colors.deepPurple,
        elevation: 4.0,
      ),
      body: Consumer<TournamentProvider>(
        builder: (context, tournamentProvider, child) {
          if (tournamentProvider.tournament == null || tournamentProvider.tournament!.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: tournamentProvider.tournament?.length,
            itemBuilder: (context, index) {
              final tournament = tournamentProvider.tournament?[index];
              return TournamentCard(tournament: tournament);
            },
          );
        },
      ),
    );
  }
}

class TournamentCard extends StatelessWidget {
  final dynamic tournament;

  const TournamentCard({Key? key, required this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.deepPurple.shade100,
              child: Icon(
                tournament?.canRegister == true ? Icons.check_circle : Icons.cancel,
                color: tournament?.canRegister == true ? Colors.green : Colors.red,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${tournament?.id ?? "Torneig desconegut"}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  if (tournament?.time != null)
                    Text(
                      'Hora: ${tournament?.time}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        tournament?.winner != null ? Icons.emoji_events : Icons.timer,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Guanyador: ${tournament?.winner ?? "Per veure :)"}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Botón o etiqueta
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: tournament?.canRegister == true ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tournament?.canRegister == true ? "Obert" : "Acabat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: tournament?.canRegister == true ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
