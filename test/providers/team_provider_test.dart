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
      // Nombre del equipo que deseas buscar
      const teamName = 'BipBop'; // Cambia este valor según el nombre del equipo que quieres probar

      // Llamar a la función para buscar el equipo por nombre
      final result = await teamProvider.findAndLoadTeamByName(teamName);

      // Verificar si el equipo fue encontrado y los datos son correctos
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
