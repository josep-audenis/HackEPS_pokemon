import 'package:flutter/cupertino.dart';

import '../models/tournament.dart';
import '../services/api_service.dart';

class TournamentProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Tournament>? _tournaments;
  List<Tournament>? get tournament => _tournaments;

  void fetchTournaments() async {
    try {
      // Realizas la solicitud a la API
      final response = await _apiService.request(endpoint: 'tournaments', method: 'GET');
      print('Response: $response');

      // Inicializa la lista de torneos
      _tournaments = [];

      // Verifica si la respuesta es válida
      if (response != null && response is List) {
        for (var element in response) {
          if (element is Map<String, dynamic>) {
            // Convierte cada elemento en un objeto Tournament
            _tournaments?.add(Tournament.fromJson(element));
          }
        }
        // Notifica a los listeners para que los widgets que dependan de esta lista se actualicen
        notifyListeners();
      }
    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }
  }

  Tournament? getById(String id){
    return tournament?.singleWhere((element) => element.id == id);
  }
}
