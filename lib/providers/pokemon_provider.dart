import 'package:flutter/material.dart';
import 'package:lspokedex/services/api_service.dart';
import 'package:lspokedex/models/pokemon.dart';

class PokemonProvider extends ChangeNotifier{
  final ApiService _apiService = ApiService();

  Future<List<Map<String, String>>> getFilteredPokemons() async {
    try {
      final response = await _apiService.request(
        endpoint: 'pokemons',
        method: 'GET',
      );

      List<Map<String, String>> filteredItems = [];

      for (var pokemonJson in response) {
        filteredItems.add({
          'id': pokemonJson['id'].toString(),
          'name': pokemonJson['name'],
          'imageUrl': pokemonJson['image'],
        });
      }

      return filteredItems;
    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }
  }
}

