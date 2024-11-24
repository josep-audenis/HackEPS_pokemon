import 'package:flutter_test/flutter_test.dart';
import 'package:lspokedex/providers/team_provider.dart';
import 'package:lspokedex/services/api_service.dart';

void main() {
  group('TeamProvider Real API Tests', () {
    late TeamProvider teamProvider;

    setUp(() {
      final apiService = ApiService();
      teamProvider = TeamProvider();
    });

    test('findAndLoadTeamByName should load team data from real API', () async {
      const teamName = 'BipBop';
      final result = await teamProvider.findAndLoadTeamByName(teamName);

      if (result) {
        print('Equipo encontrado: ${teamProvider.currentTeam}');
        expect(teamProvider.currentTeam, isNotNull);
        expect(teamProvider.currentTeam!.name, equals(teamName));
      } else {
        print('El equipo no fue encontrado.');
        expect(result, isFalse);
      }
    });
  });
}
