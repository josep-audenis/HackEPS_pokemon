import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/team_provider.dart'; // Ruta correcta
import '../services/api_service.dart'; // Ruta correcta para el servicio API
import 'detalles_pokemon_screen.dart'; // Ruta correcta

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
            // Verifica si el equipo está cargado
            if (teamProvider.currentTeam == null) {
              return const CircularProgressIndicator();
            }

            // Almacena los IDs de los Pokémon en una variable
            List<String> ids = teamProvider.getPokemonsIds();

            // Si los IDs están disponibles, muestra la lista
            return ListView.builder(
              itemCount: ids.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  // Llama a la API para obtener detalles del Pokémon
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

                      // Muestra el rectángulo con los detalles del Pokémon
                      return GestureDetector(
                        onTap: () {
                          // Navega a la pantalla de detalles con el ID del Pokémon
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
                          padding: const EdgeInsets.all(8.0), // Espaciado alrededor de cada tarjeta
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
                              padding: const EdgeInsets.all(12.0), // Espaciado interno
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Detalles del Pokémon (nombre)
                                      Expanded(
                                        child: Text(
                                          pokemon['name'], // Nombre del Pokémon
                                          style: const TextStyle(
                                            fontSize: 22, // Tamaño de fuente más grande
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // Imagen del Pokémon
                                      Image.network(
                                        pokemon['image'], // URL de la imagen del Pokémon
                                        height: 80, // Altura aumentada
                                        width: 80,  // Ancho aumentado
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Botón "Evolution" centrado
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Evolución de ${pokemon['name']}'),
                                          ),
                                        );
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
