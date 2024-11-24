import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/team_provider.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProvider>(context);

    final pveScore = teamProvider.currentTeam?.pve_score ?? 0;
    final pvpScore = teamProvider.currentTeam?.pvp_score ?? 0;
    final pokedexScore = teamProvider.currentTeam?.pokedex_score ?? 0;
    final capturedPokemons = teamProvider.currentTeam?.captured_pokemons ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Equip Hackathon"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Image.network(
                'https://pokemonletsgo.pokemon.com/assets/img/how-to-play/hero-img.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/davidCard.png', width: 100, height: 150),
                    const SizedBox(width: 8),
                    Image.asset('assets/images/josepCard.png', width: 100, height: 150),
                    const SizedBox(width: 8),
                    Image.asset('assets/images/marinaCard.png', width: 100, height: 150),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.black,
                      width: 1,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(250),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      _buildTableRow("PVE Score", pveScore.toString(), isGray: true),
                      _buildTableRow("PVP Score", pvpScore.toString(), isGray: false),
                      _buildTableRow("Pokedex Score", pokedexScore.toString(), isGray: true),
                      _buildTableRow("Pokémon Capturados", capturedPokemons.length.toString(), isGray: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value, {bool isGray = false}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isGray ? Colors.grey[300] : Colors.white,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(value, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
