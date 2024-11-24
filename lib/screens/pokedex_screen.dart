import 'package:flutter/material.dart';
import 'package:lspokedex/providers/event_provider.dart';
import 'package:lspokedex/providers/team_provider.dart';
import 'package:lspokedex/utills/constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lspokedex/models/pokemon.dart';
import 'package:lspokedex/screens/user_profile_screen.dart';
import 'package:lspokedex/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

import 'detalles_pokemon_screen.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {

  
  // Controlador de búsqueda
  TextEditingController _searchController = TextEditingController();
  
  
  
  PokemonProvider _pokemonProvider = PokemonProvider();


  // Lista filtrada de elementos según la búsqueda
  List<Map<String, String>> filteredItems = [];
  List<Map<String, String>> _originalItems = [];

  @override
  void initState() {
    super.initState();
    _fetchPokemons(); // Cargar datos desde la API
    _searchController.addListener(_filterItems);
  }

  Future<void> _fetchPokemons() async {
    try {
      // Obtén la lista de Pokémon desde la API
      _originalItems  = await _pokemonProvider.getFilteredPokemons();
      setState(() {
        filteredItems = _originalItems;
      });
    } catch (e) {
      print('Error al obtener Pokémons: $e');
    }
  }

  // Método para filtrar los elementos según el texto de búsqueda
  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredItems = _originalItems
          .where((item) => item['name']!.toLowerCase().contains(query))
          .toList();
    });
  }

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
            content:
            const Text("La aplicación necesita acceso a la cámara para escanear códigos QR."),
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
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

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
                        List<String> parts = code.split('/');
                        eventProvider.cancelTimer();
                        eventProvider.performPostForLocation(parts.last, teamId);
                        eventProvider.executeOperationsForLocations(teamId);
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
  void dispose() {
    _searchController.removeListener(_filterItems);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFcc544a),
        title: const Text('Pokedex'),
        actions: [
          // Campo de búsqueda en la barra de aplicaciones
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: PokedexSearchDelegate(filteredItems),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fondo principal
          Container(
            color: Colors.white,
          ),

          // Campo de búsqueda
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Pokémon...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Cuadrícula de elementos filtrados
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Número de columnas
                      crossAxisSpacing: 8, // Espaciado horizontal
                      mainAxisSpacing: 8, // Espaciado vertical
                      childAspectRatio: 0.8, // Proporción entre ancho y alto
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          // Navegar a la pantalla de detalles con el Pokémon seleccionado
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesPokemonScreen(pokemonId: item['id']!),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    item['imageUrl']!, // URL de la imagen
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child; // Imagen cargada
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.error, // Icono en caso de error
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    item['name']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
                  const SizedBox(height: 8),

                  // Opciones centrales
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        heroTag: 'left',
                        onPressed: () {
                          // Acción para abrir la pantalla de usuario
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfileScreen(),
                            ),
                          );
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
                      const SizedBox(width: 8),
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
                      const SizedBox(width: 8),
                      FloatingActionButton(
                        heroTag: 'right',
                        onPressed: () {
                          // Acción derecha
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
                  const SizedBox(height: 8),

                  // Opción inferior
                  FloatingActionButton(
                    heroTag: 'down',
                    onPressed: () {
                      // Acción inferior
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

class PokedexSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> items;

  PokedexSearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredItems = items
        .where((item) =>
        item['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    item['imageUrl']!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    item['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredItems = items
        .where((item) =>
        item['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    item['imageUrl']!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    item['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
