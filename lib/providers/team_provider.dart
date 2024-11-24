import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lspokedex/services/api_service.dart';
import 'package:lspokedex/utills/constants.dart';
import '../models/team.dart';


class TeamProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Team? _currentTeam;
  Team? get currentTeam => _currentTeam;
  String? get team_id => _currentTeam?.id;

  Future<bool> findAndLoadTeamByName(String teamName) async {
    try {
      final response = await _apiService.request(endpoint: 'teams/$teamId', method: 'GET');
      
      // List<dynamic> teams = response;
      
      if (response != null) {
        _currentTeam = Team.fromJson(response);
        notifyListeners();
        return true;    // Equip trobat i guardat :)
      } else {
        return false;   // Equip no trobat :(
      }
    } catch (e) {
      print('ERROR: unexpected search team result: $e');
      return false;
    }
  }

  Future<bool> evolveTo(int id) async {
        
    try {
      final pokemonResponse = await _apiService.request(
        endpoint: "pokemons/$id", 
        method: 'GET'
      );

      Map<String, dynamic> pre_evolution = json.decode(pokemonResponse);
      if (pre_evolution.containsKey('evolves_to') && pre_evolution['evolves_to'] != null) {
        Map<String, dynamic> evolvesTo = pre_evolution['evolves_to'];
        
        String evolvedPokemonId = evolvesTo['id'];

        print('The evolved Pokémon ID is: $evolvedPokemonId');

        if (((currentTeam?.captured_pokemons.where((pokemon) => pokemon.pokemon_id == id))?.length ?? 0) >= 3) {
          List<String>? selected;
          for (var pokemon in currentTeam!.captured_pokemons){
            selected!.add(pokemon.id);
            if (selected.length == 3) break;
          }
          final response = await _apiService.request(
            endpoint: 'pokemons/$id/evolve', 
            method: 'POST',
            body: {
              "pokemon_uuid_list": "[${selected![0]}, ${selected[1]}, ${selected[2]}]", "team_id": "52c712ae-2f10-44e2-b734-e9659f5617f0"
            },
          );

          currentTeam?.captured_pokemons.firstWhere((pokemon) => pokemon.pokemon_id == id).pokemon_id = evolvedPokemonId as int;
          currentTeam?.captured_pokemons.removeWhere((pokemon) => pokemon.id == selected[1]);
          currentTeam?.captured_pokemons.removeWhere((pokemon) => pokemon.id == selected[2]);

        } else {
          print('This Pokémon does not have an evolution.');
        }
      }

    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }

    return false;
  }

  List<String> getPokemonsIds () {
    List<String> list = [];
    for (var pokemon in _currentTeam!.captured_pokemons) {
      list.add(pokemon.pokemon_id.toString());
    }
    return list;
  }
}
