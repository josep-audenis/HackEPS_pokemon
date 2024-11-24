import 'package:lspokedex/services/api_service.dart';
import 'package:lspokedex/models/pokemon.dart';

class PokemonProvider {
  final ApiService _apiService = ApiService();

  Future<List<Pokemon>> getPokemons() async {
    try {
      // Realizamos la solicitud GET para obtener los pokemones
      final response = await _apiService.request(
        endpoint: 'pokemons',
        method: 'GET',
      );

      //Verifiquem si la resposta conté dades
      if (response is List) {
        //Convertim la resposta a una array de pokemons
        return response.map((pokemonJson) => Pokemon.fromJson(pokemonJson)).toList();
      } else {
        throw Exception('ERROR: Invalid response format');
      }
    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }
  }
}
