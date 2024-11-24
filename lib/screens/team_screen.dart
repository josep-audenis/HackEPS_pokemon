import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/team_provider.dart'; 
import '../services/api_service.dart'; 
import 'detalles_pokemon_screen.dart'; 

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Pokemon team'),
        backgroundColor: const Color(0xFFcc544a),
      ),
      body: Center(
        child: Consumer<TeamProvider>(
          builder: (context, teamProvider, child) {
            if (teamProvider.currentTeam == null) {
              return const CircularProgressIndicator();
            }

            List<String> ids = teamProvider.getPokemonsIds();

            return ListView.builder(
              itemCount: ids.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: ApiService().request(
                    endpoint: '/pokemons/${ids[index]}',
                    method: 'GET',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      var pokemon = snapshot.data as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesPokemonScreen(
                                pokemonId: ids[index],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0), 
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0), 
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          pokemon['name'], 
                                          style: const TextStyle(
                                            fontSize: 22, 
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Image.network(
                                        pokemon['image'], 
                                        height: 80, 
                                        width: 80,  
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        int id = pokemon['id'];
                                        if (((teamProvider.currentTeam?.captured_pokemons.where((pokemon) => pokemon.pokemon_id == id))?.length ?? 0) >= 3){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Evolution ${pokemon['name']}'),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Cannot evolve ${pokemon['name']}'),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Evolution'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
