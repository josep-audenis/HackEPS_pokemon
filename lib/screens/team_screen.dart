import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/team_provider.dart';  // Asegúrate de que la ruta es correcta

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Llamar a la función para cargar el equipo
    //final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    
    // Llamamos a la función _loadTeam para cargar el equipo

    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Screen'),
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
                // Imprime el ID del Pokémon en la consola
                print('Pokemon ID: ${ids[index]}');

                return ListTile(
                  title: Text('Pokemon ID: ${ids[index]}'),  // Muestra el ID de cada Pokémon
                );
              },
            );
          },
        ),
      ),
    );
  }
}
