import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  // Datos de ejemplo
  final String name = "Pokedex Project";
  final List<String> creatorsImages = [
    'assets/images/davidCard.png',
    'assets/images/josepCard.png',
    'assets/images/marinaCard.png',
  ];

  final int pveScore = 0;
  final int pvpScore = 0;
  final int pokedexScore = 0;
  final List<String> capturedPokemons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equip Hackathon"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            //Es mostren imatges de l'equip.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: creatorsImages.map((imagePath) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 100,  
                    height: 150, 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),  // Bordes redondeados (si los deseas)
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,  // Ajustar la imagen dentro del contenedor
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Mostrar puntuaciones y Pokémon capturados
            Text(
              "PVE Score: $pveScore",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "PVP Score: $pvpScore",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Pokedex Score: $pokedexScore",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Pokémon Capturados: ${capturedPokemons.length}",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
