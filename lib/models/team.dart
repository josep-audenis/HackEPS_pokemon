import 'package:lspokedex/models/pokemon.dart';

class Team {
    
    final String id;
    final String name;
    final double pve_score;
    final double pvp_score;
    final double pokedex_score;
    final List<Pokemon> captured_pokemons;
    final bool is_active;

    Team({
        required this.id,
        required this.name,
        required this.pve_score,
        required this.pvp_score,
        required this.pokedex_score,
        required this.captured_pokemons,
        required this.is_active,
    });

    //Funció usada per a convertir la resposta del fitxer json a un objecte del tipus Team
    factory Team.jsonToTeam(Map<String, dynamic> json) {
        return Team(
            id: json['id'],
            name: json['name'],
            pve_score: json['pve_score'],
            pvp_score: json['pvp_score'],
            pokedex_score: json['pokedex_score'],
            captured_pokemons: List<Pokemon>.from(json['captured_pokemons']), //captured_pokemons: List<Pokemon>.from(json['captured_pokemons'].map((pokemonJson) => Pokemon.jsonToPokemon(pokemonJson))),

            is_active: json['is_active'],
        );
    }

    //Funció usada per a obtenir el team id del equip.
    String getTeamId() {
        return id; 
    }
    
}
