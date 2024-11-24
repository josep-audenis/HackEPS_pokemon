import 'package:flutter/material.dart';
import 'package:lspokedex/services/api_service.dart';  

class DetallesPokemonScreen extends StatelessWidget {
  final String pokemonId;

  const DetallesPokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFe5282a),
        title: const Text(
          'Detalles Pokémon',
          style: TextStyle(color: Colors.white),  
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pokedes-background.jpg'),  
            fit: BoxFit.cover,  
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: ApiService().request(
              endpoint: '/pokemons/$pokemonId',  
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

                return ListView(
                  children: [
                    const SizedBox(height: 80),

                    Align(
                      alignment: Alignment.centerRight,  
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),  
                        child: Text(
                          pokemon['name'],
                          style: const TextStyle(
                            fontSize: 35,  
                            fontWeight: FontWeight.bold,
                            color: Colors.white,  
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Center(
                      child: Image.network(
                        pokemon['image'],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Habilidades:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),  
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var ability in pokemon['abilities'])
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),  
                                        child: Text(
                                          '• ${ability['ability']['name']}',
                                          style: const TextStyle(fontSize: 16, color: Colors.white),  
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _buildInfoCard('Peso', '${pokemon['weight']} kg', Colors.grey[300]!, Colors.black), 
                              const SizedBox(height: 16),  
                              _buildInfoCard('Altura', '${pokemon['height']} m', Colors.grey[300]!, Colors.black), 
                              const SizedBox(height: 16),  
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
                return const Center(child: Text('No data found', style: TextStyle(color: Colors.white)));  
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, Color backgroundColor, Color textColor) {
    return Container(
      width: 90,
      height: 65,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor,  
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,  
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: textColor),  
          ),
        ],
      ),
    );
  }
}
