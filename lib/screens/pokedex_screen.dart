import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  /// Solicita el permiso para usar la cámara.
  Future<void> _requestCameraPermission(BuildContext context) async {
    var status = await Permission.camera.status;

    if (!status.isGranted) {
      // Solicita permiso de cámara si no está concedido
      status = await Permission.camera.request();
      if (!status.isGranted) {
        // Muestra un diálogo indicando que se necesita el permiso
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Permiso requerido"),
            content: const Text("La aplicación necesita acceso a la cámara para escanear códigos QR."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            ],
          ),
        );
      }
    }
  }

  /// Muestra el escáner QR en un panel flotante.
  void _showScanner(BuildContext context) async {
    // Verifica y solicita permisos antes de abrir la cámara
    await _requestCameraPermission(context);

    // Muestra el escáner QR en un Bottom Sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Fondo transparente
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Barra superior para deslizar
                  Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: MobileScanner(
                      fit: BoxFit.cover,
                      onDetect: (BarcodeCapture barcode) {
                        final String code = barcode.barcodes.isNotEmpty
                            ? barcode.barcodes.first.rawValue ?? 'Código no detectado'
                            : 'Código no detectado';

                        print('Código QR detectado: $code');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFcc544a),
        title: const Text('Pokedex'),
      ),
      body: Stack(
        children: [
          // Fondo principal
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
                          height: 24,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Team',
                          style: TextStyle(
                            fontSize: 10,
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
                        onPressed: () => _showScanner(context),
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
