import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:async';

class EventProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  final Map<String, Timer> _timers = {};
  Map<String, String> lastCapture = {};
  Set<String> _locationCodes = {};
  Set<String> get locationCodes => _locationCodes;

  Future<void> loadLocationCodes() async {
    try {
      final response = await _apiService.request(endpoint: 'pokemons', method: 'GET');

      if (response is List<dynamic>) {
        List<dynamic> pokemons = response;

        for (var pokemon in pokemons) {
          if (pokemon is Map<String, dynamic> &&
              pokemon['location_area_encounters'] != null) {
            List<dynamic> locations = pokemon['location_area_encounters'];

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
    } catch (e) {
      print('ERROR: couldn\'t parase pokemons: $e');
    }
  }

  Future<void> executeOperationsForLocations(String team_id) async {
    for (var location in _locationCodes) {
      try {
        final delayResponse = await _apiService.request(
          endpoint: 'zones/$location',
          method: 'GET',
        );

        if (delayResponse is Map<String, dynamic> && delayResponse['cooldown_period'] != null) {
          double cooldownPeriod = delayResponse['cooldown_period'];

          int delay = cooldownPeriod.toInt();

          print('Tiempo de espera para la ubicación $location: $delay segundos');
          _timers[location]?.cancel();

          _timers[location] = Timer.periodic(
            Duration(seconds: delay),
            (_) async {
              await performPostForLocation(location, team_id);
            },
          );
        } else {
          print('ERROR: No se encontró un tiempo de espera válido para la ubicación $location');
        }
      } catch (e) {
        print('ERROR: No se pudo obtener el tiempo de espera para $location: $e');
      }
    }
  }

  Future<void> performPostForLocation(String location, String team_id) async {
    try {
      final postResponse = await _apiService.request(
        endpoint: 'events/$location',
        method: 'POST',
        body: {
          'team_id': "52c712ae-2f10-44e2-b734-e9659f5617f0"
        },
      );

      if (postResponse is Map<String, dynamic>) {
        print('POST ejecutado con éxito para $location: $postResponse');
      } else {
        print('ERROR: Respuesta inesperada del POST para $location: $postResponse');
      }
    } catch (e) {
      print('ERROR: No se pudo ejecutar el POST para $location: $e');
    }
  }
}
