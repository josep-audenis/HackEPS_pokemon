import 'package:flutter/cupertino.dart';

import '../models/tournament.dart';
import '../services/api_service.dart';

class TournamentProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Tournament>? _tournaments;
  List<Tournament>? get tournament => _tournaments;

  void fetchTournaments() async {
    try {
      final response = await _apiService.request(endpoint: 'tournaments', method: 'GET');
      print('Response: $response');

      _tournaments = [];

      if (response != null && response is List) {
        for (var element in response) {
          if (element is Map<String, dynamic>) {
            _tournaments?.add(Tournament.fromJson(element));
          }
        }
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
