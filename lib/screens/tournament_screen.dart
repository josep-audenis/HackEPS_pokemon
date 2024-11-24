import 'package:flutter/cupertino.dart';
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
    // Forzar la carga de torneos después de que se haya construido la pantalla
    Future.delayed(Duration.zero, () {
      Provider.of<TournamentProvider>(context, listen: false).fetchTournaments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tournaments')),
      body: Consumer<TournamentProvider>(
        builder: (context, tournamentProvider, child) {
          // Si no hay torneos cargados, mostramos un mensaje de carga
          if (tournamentProvider.tournament!.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Si hay torneos, mostramos una lista
          return ListView.builder(
            itemCount: tournamentProvider.tournament?.length,
            itemBuilder: (context, index) {
              final tournament = tournamentProvider.tournament?[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${tournament?.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (tournament?.time != null) Text('Time: ${tournament?.time}'),
                      Text('Can Register: ${tournament?.canRegister ? "Yes" : "No"}'),
                      Text('Winner: ${tournament?.winner ?? "TBD"}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
