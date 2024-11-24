import 'package:flutter/material.dart';
import 'package:lspokedex/services/api_service.dart';
import 'package:lspokedex/models/pokemon.dart';

class PokemonProvider extends ChangeNotifier{
  final ApiService _apiService = ApiService();

  Future<List<Map<String, String>>> getFilteredPokemons() async {
    try {
      // Realizamos la solicitud GET para obtener los pokemones
      final response = await _apiService.request(
        endpoint: 'pokemons',
        method: 'GET',
      );

      // Inicializamos la lista para almacenar los datos procesados
      List<Map<String, String>> filteredItems = [];

      // Recorremos cada elemento del JSON y extraemos los campos necesarios
      for (var pokemonJson in response) {
        filteredItems.add({
          'id': pokemonJson['id'].toString(),
          'name': pokemonJson['name'],
          'imageUrl': pokemonJson['image'],
        });
      }

      // Retornamos la lista procesada
      return filteredItems;
    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }
  }
}

