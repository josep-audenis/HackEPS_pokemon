import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:async';

class EventProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Timer? _timer;
  Set<String> _locationCodes = {};
  Set<String> get locationCodes => _locationCodes;


  Future<void> loadLocationCodes() async {
    try {
      final response = await _apiService.request(endpoint: 'pokemons', method: 'GET');

      if (response is List<dynamic>) {
        List<dynamic> pokemons = response;

        for (var pokemon in pokemons) {
          if (pokemon is Map<String, dynamic> && pokemon['location_area_encounters'] != null) {
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

  // void startMonitoringZones(int intervalInSeconds) {
  //   _timer?.cancel();

  //   _timer = Timer.periodic(Duration(seconds: intervalInSeconds), (timer) async {
  //     await _checkZones();
  //   });
  // }

  // void stopMonitoringZones() {
  //   _timer?.cancel();
  // }

  // Future<void> _checkZones(int team_id) async {
  //   try {
  //     final response = await _apiService.request(endpoint: 'zones', method: 'GET');
  //     List<dynamic> zones = response;

  //     for (var zone in zones) {
  //       if (zone['cooldown'] == 0) {
  //         final zoneId = zone['zone_id'];
  //         final teamId = team_id; 

  //         await _apiService.request(
  //           endpoint: 'event',
  //           method: 'POST',
  //           headers: {'Content-Type': 'application/json'},
  //           body: {'zone_id': zoneId, 'team_id': teamId},
  //         );

  //         print('Pokémon capturado en la zona: $zoneId');
  //       } else {
  //         print('Zona ${zone['zone_id']} está en cooldown por ${zone['cooldown']} segundos.');
  //       }
  //     }
  //   } catch (e) {
  //     print('ERROR: Fallo al consultar las zonas: $e');
  //   }
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }



}