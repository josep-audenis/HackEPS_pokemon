import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  // Datos de ejemplo
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
        backgroundColor: Colors.transparent, // Eliminar fondo del AppBar
        elevation: 0, // Elimina la sombra debajo del AppBar
      ),
      body: Stack(
        children: [
          // Imagen de fondo ocupando la mitad inferior de la pantalla
          Positioned(
            bottom: 0, // Alinea la imagen al fondo
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2, // La mitad de la altura de la pantalla
              child: Image.network(
                'https://pokemonletsgo.pokemon.com/assets/img/how-to-play/hero-img.png',
                fit: BoxFit.cover, // Hace que la imagen ocupe todo el contenedor
              ),
            ),
          ),
          // Capa blanca semi-transparente encima de la imagen
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.6), // Capa blanca semi-transparente
            ),
          ),
          // Contenido principal sobre la imagen y la capa blanca
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                // Es mostrarán imágenes del equipo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: creatorsImages.map((imagePath) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8), // Bordes redondeados
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover, // Ajuste de imagen dentro del contenedor
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // Cuadrícula con nombre y valor
                Padding(
                  padding: const EdgeInsets.all(8.0), // Padding extra alrededor de la tabla
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.black, // Color de los bordes
                      width: 1, // Grosor del borde
                      borderRadius: BorderRadius.circular(5), // Bordes redondeados
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(250),  // Aumentamos más el ancho de la primera columna
                      1: FlexColumnWidth(),  // La segunda columna se ajustará al espacio disponible
                    },
                    children: [
                      // Fila 1: Fondo gris
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Color gris para las filas impares
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "PVE Score",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center( // Centrar el texto en la segunda columna
                              child: Text("$pveScore", style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                      // Fila 2: Fondo blanco
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white, // Color blanco para las filas pares
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "PVP Score",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center( // Centrar el texto en la segunda columna
                              child: Text("$pvpScore", style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                      // Fila 3: Fondo gris
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Color gris para las filas impares
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pokedex Score",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center( // Centrar el texto en la segunda columna
                              child: Text("$pokedexScore", style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                      // Fila 4: Fondo blanco
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white, // Color blanco para las filas pares
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pokémon Capturados",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center( // Centrar el texto en la segunda columna
                              child: Text("${capturedPokemons.length}", style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
