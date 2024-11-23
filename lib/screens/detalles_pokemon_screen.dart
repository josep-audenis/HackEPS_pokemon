import 'package:flutter/material.dart';

class DetallesPokemonScreen extends StatelessWidget {
  final Map<String, String> pokemon;

  // Constructor para recibir los datos
  const DetallesPokemonScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFcc544a),
        title: Text(pokemon['name'] ?? 'Detalles Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              pokemon['imageUrl'] ?? '',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              pokemon['name'] ?? 'Sin nombre',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Puedes agregar más detalles aquí, como tipo, habilidades, etc.
          ],
        ),
      ),
    );
  }
}
