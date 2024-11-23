import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EventProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Set<String> _locationCodes = {};
  Set<String> get locationCodes => _locationCodes;


  Future<void> loadLocationCodes() async {
    try {
      final response = await _apiService.request(endpoint: 'pokemon', method: 'GET');
      
      List<dynamic> pokemons = response;

      //parseja totes les location_area_encounter
      for (var pokemon in pokemons) {
        if (pokemon['location_area_encounter'] != null) {
          _locationCodes.add(pokemon['location_area_encounter']);
        }
      }

      notifyListeners();
    } catch (e) {
      print('ERROR: couldn\'t parase pokemons: $e');
    }
  }
}