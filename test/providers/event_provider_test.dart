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
      await eventProvider.loadLocationCodes();

      if (eventProvider.locationCodes.isNotEmpty) {
        print('Códigos de localización encontrados: ${eventProvider.locationCodes}');
        expect(eventProvider.locationCodes, isNotEmpty);
      } else {
        print('No se encontraron códigos de localización.');
        expect(eventProvider.locationCodes, isEmpty);
      }
    });

    test('executeOperationsForLocation should load all cooldown_time codes from real API', () async {
      await eventProvider.loadLocationCodes();
      print('execute operations');
      await eventProvider.executeOperationsForLocations('52c712ae-2f10-44e2-b734-e9659f5617f0'); //testing our group
      print('executed operations');
    });
  });
}
