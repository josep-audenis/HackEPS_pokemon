import 'package:flutter/material.dart';
import 'package:lspokedex/models/tournament.dart';
import 'package:lspokedex/services/api_service.dart';

class TournamentProvider extends ChangeNotifier{
  final ApiService _apiService = ApiService();

  List<Tournament>? _tournaments;
  List<Tournament>? get tournament => _tournaments;

  void fetchTournamets() async {
    
    try {
      final response = await _apiService.request(endpoint: 'tournaments', method: 'GET');
      _tournaments?.clear();
      for (var element in response) {
        _tournaments?.add(Tournament.fromJson(element));
      }
    } catch(e) {
      print('ERROR: $e');
      rethrow;
    }
  }

  Tournament? getById(String id){
    return tournament?.singleWhere((element) => element.id == id);
  }

}