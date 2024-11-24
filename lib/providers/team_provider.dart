import 'package:flutter/material.dart';
import 'package:lspokedex/utills/constants.dart';
import '../models/team.dart';
import '../services/api_service.dart';

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
}
