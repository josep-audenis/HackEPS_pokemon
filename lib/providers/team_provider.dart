// import 'package:flutter/material.dart';
// import '../models/team.dart';
// import '../services/api_service.dart';

// class TeamProvider extends ChangeNotifier {
//   final ApiService _apiService = ApiService();

//   Team? _currentTeam;
//   Team? get currentTeam => _currentTeam;

//   Future<bool> findAndLoadTeamByName(String teamName) async {
//     try {
//       final response = await _apiService.request(endpoint: 'teams', method: 'GET');
      
//       List<dynamic> teams = response;
//       List<Map<String, dynamic>> mappedTeams = teams.map((team) => Map<String, dynamic>.from(team)).toList();

//       final teamData = mappedTeams.firstWhere((team) => team['name'] == teamName, orElse: () => {});
      
//       if (teamData.isNotEmpty) {
//         _currentTeam = Team.jsonToTeam(teamData);
//         notifyListeners();
//         return true;    // Equip trobat i guardat :)
//       } else {
//         return false;   // Equip no trobat :(
//       }
//     } catch (e) {
//       print('ERROR: unexpected search team result: $e');
//       return false;
//     }
//   }
// }
