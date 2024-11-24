import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Screen'),
      ),
      body: Center(
        child: Text(
          'Adio',  // Aquí está el texto "Adio"
          style: TextStyle(
            fontSize: 30,       // Tamaño de fuente
            fontWeight: FontWeight.bold,  // Estilo en negrita
            color: Colors.black, // Color del texto
          ),
        ),
      ),
    );
  }
}
