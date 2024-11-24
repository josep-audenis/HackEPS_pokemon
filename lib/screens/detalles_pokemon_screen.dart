import 'package:flutter/material.dart';
import 'package:lspokedex/services/api_service.dart';  // Importar la clase ApiService

class DetallesPokemonScreen extends StatelessWidget {
  final String pokemonId;  // Usamos pokemonId para hacer la consulta

  // Constructor para recibir solo el pokemonId
  const DetallesPokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFe5282a),
        title: const Text(
          'Detalles Pokémon',
          style: TextStyle(color: Colors.white),  // Título en blanco
        ),
      ),
      body: Container(
        // Fondo con imagen desde los assets
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pokedes-background.jpg'),  // Imagen desde assets
            fit: BoxFit.cover,  // Asegura que la imagen cubra toda la pantalla
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            // Realizamos la consulta a la API pasando el pokemonId
            future: ApiService().request(
              endpoint: '/pokemons/$pokemonId',  // Endpoint que usa el pokemonId
              method: 'GET',
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
              }

              if (snapshot.hasData) {
                var pokemon = snapshot.data as Map<String, dynamic>;

                // Mostrar los detalles del Pokémon una vez que los datos están disponibles
                return ListView(
                  children: [
                    const SizedBox(height: 80), // Espacio adicional arriba

                    // Nombre del Pokémon
                    Align(
                      alignment: Alignment.centerRight,  // Alinea a la derecha
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),  // Opcional: añadir un poco de margen a la derecha
                        child: Text(
                          pokemon['name'],
                          style: const TextStyle(
                            fontSize: 35,  // Aumenta el tamaño del texto
                            fontWeight: FontWeight.bold,
                            color: Colors.white,  // Texto en blanco
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Imagen del Pokémon
                    Center(
                      child: Image.network(
                        pokemon['image'],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Disposición de las dos columnas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Columna izquierda (Habilidades)
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Habilidades:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),  // Texto en blanco
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var ability in pokemon['abilities'])
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),  // Añade la tabulación
                                        child: Text(
                                          '• ${ability['ability']['name']}',
                                          style: const TextStyle(fontSize: 16, color: Colors.white),  // Texto en blanco
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Columna derecha (Peso, Altura, Especie)
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _buildInfoCard('Peso', pokemon['weight'].toString(), Colors.grey[300]!, Colors.black),
                              const SizedBox(height: 16),  // Espacio entre los cuadros
                              _buildInfoCard('Altura', pokemon['height'].toString(), Colors.grey[300]!, Colors.black),
                              const SizedBox(height: 16),  // Espacio entre los cuadros
                              _buildInfoCard('Especie', pokemon['species']['name'], Colors.grey[300]!, Colors.black),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                  ],
                );
              } else {
                return const Center(child: Text('No data found', style: TextStyle(color: Colors.white)));  // Texto en blanco
              }
            },
          ),
        ),
      ),
    );
  }

  // Método para construir las tarjetas de información con fondo gris claro y texto negro
  Widget _buildInfoCard(String label, String value, Color backgroundColor, Color textColor) {
    return Container(
      width: 70,
      height: 60,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor,  // Fondo gris claro
        borderRadius: BorderRadius.circular(8.0),  // Bordes redondeados
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Centra el contenido
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,  // Texto negro
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: textColor),  // Texto negro
          ),
        ],
      ),
    );
  }
}
