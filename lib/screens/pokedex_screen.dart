import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFcc544a),
        title: const Text('Pokedex'),
      ),
      body: Stack(
        children: [
          // Fondo (puedes reemplazarlo con tu contenido principal)
          Container(
            color: Colors.white,
          ),

          // Menú flotante
          Positioned(
            bottom: 50.0, // Espaciado desde el fondo
            right: 20.0, // Espaciado desde la derecha
            child: Container(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Opción superior
                  FloatingActionButton(
                    heroTag: 'up',
                    onPressed: () {
                      // Acción para la opción superior
                    },
                    backgroundColor: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/team.png',
                          fit: BoxFit.cover,
                          height: 24, // Tamaño de la imagen
                        ),
                        const SizedBox(height: 4), // Espaciado entre imagen y texto
                        const Text(
                          'Team',
                          style: TextStyle(
                            fontSize: 10, // Tamaño de la fuente
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8), // Espaciado

                  // Opciones centrales (tres botones en paralelo)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        heroTag: 'left',
                        onPressed: () {
                          // Acción para la opción izquierda
                        },
                        backgroundColor: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/user.png',
                              fit: BoxFit.cover,
                              height: 24,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'User',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8), // Espaciado
                      FloatingActionButton(
                        heroTag: 'middle',
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Escanea un QR"),
                                content: MobileScanner(
                                  onDetect: (BarcodeCapture barcode) {
                                    final String code = barcode.rawValue ?? 'Código no detectado';
                                    print('Código QR detectado: $code');  // Imprime el QR escaneado en la terminal
                                    Navigator.pop(context);  // Cierra el diálogo después de escanear
                                  },
                                ),
                              );
                            },
                          );
                        },
                        backgroundColor: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/camera.png',
                              fit: BoxFit.cover,
                              height: 24,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Capture',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8), // Espaciado
                      FloatingActionButton(
                        heroTag: 'right',
                        onPressed: () {
                          // Acción para la opción derecha
                        },
                        backgroundColor: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/torneo.png',
                              fit: BoxFit.cover,
                              height: 24,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Tourn',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // Espaciado

                  // Opción inferior
                  FloatingActionButton(
                    heroTag: 'down',
                    onPressed: () {
                      // Acción para la opción inferior
                    },
                    backgroundColor: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/pokedex.png',
                          fit: BoxFit.cover,
                          height: 24,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Pokédex',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on BarcodeCapture {
  String get rawValue => this.barcodes.isNotEmpty ? this.barcodes.first.rawValue ?? 'Código no detectado' : 'Código no detectado';
}
