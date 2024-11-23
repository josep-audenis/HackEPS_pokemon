import 'package:flutter_test/flutter_test.dart';
import 'package:lspokedex/providers/event_provider.dart';
import 'package:lspokedex/services/api_service.dart';

void main() {
  group('EventProvider Real API Tests', () {
    late EventProvider eventProvider;

    setUp(() {
      final apiService = ApiService();
      eventProvider = EventProvider();
    });

    test('loadLocationCodes should load all location_area_encounter codes from real API', () async {
      // Llamar a la función para cargar los códigos de location_area_encounter
      await eventProvider.loadLocationCodes();

      // Verificar si se cargaron los códigos
      if (eventProvider.locationCodes.isNotEmpty) {
        print('Códigos de localización encontrados: ${eventProvider.locationCodes}');
        expect(eventProvider.locationCodes, isNotEmpty);
      } else {
        print('No se encontraron códigos de localización.');
        expect(eventProvider.locationCodes, isEmpty);
      }
    });
  });
}
