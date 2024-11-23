import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EventProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Set<String> _locationCodes = {};
  Set<String> get locationCodes => _locationCodes;


  Future<void> loadLocationCodes() async {
    try {
      final response = await _apiService.request(endpoint: 'pokemons', method: 'GET');
      
      List<dynamic> pokemons = response;


    if (response is List<dynamic>) {
      List<dynamic> pokemons = response;

      // Parsear todas las location_area_encounters
      for (var pokemon in pokemons) {
        // Verificar si 'location_area_encounters' es una lista
        if (pokemon is Map<String, dynamic> && pokemon['location_area_encounters'] != null) {
          List<dynamic> locations = pokemon['location_area_encounters'];

          // Iterar sobre cada localización y agregar al set
          for (var location in locations) {
            if (location is String) {
              _locationCodes.add(location);
            }
          }
        }
      }

      notifyListeners();
    } else {
      print('ERROR: La respuesta no es una lista, es de tipo ${response.runtimeType}');
    }
      //parseja totes les location_area_encounter
      // for (var pokemon in pokemons) {
      //   //print('${pokemon.toString()}\n');
      //   if (pokemon is Map<String, dynamic> && pokemon['location_area_encounters'] != null) {
      //     _locationCodes.add(pokemon['location_area_encounters']);
      //   }

      // }

      // notifyListeners();
    } catch (e) {
      print('ERROR: couldn\'t parase pokemons: $e');
    }
  }
}