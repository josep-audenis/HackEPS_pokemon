import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Crea un controlador para el TextField
  final TextEditingController _teamNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFcc544a),
        centerTitle: false,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand, // Esto hace que la imagen ocupe todo el fondo
        children: [
          // Fondo de color
          Container(
            color: Color(0xFFcc544a), // El color de fondo de la pantalla
          ),

          // Imagen Pikachu detrás de todos los elementos
          Positioned(
            bottom: -100.0, // Distancia desde la parte inferior
            right: -100.0,  // Distancia desde la parte derecha
            child: Image.asset(
              'assets/images/pikachu.png',
              width: 500,  // Tamaño específico de la imagen
              height: 500, // Tamaño específico de la imagen
            ),
          ),

          // Contenido encima de la imagen
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/pokebola.png',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sign in with your team name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                // TextField controlado por el TextEditingController
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: TextField(
                    controller: _teamNameController, // Asigna el controlador
                    decoration: const InputDecoration(
                      labelText: 'Team Name?',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Botón para obtener el valor del TextField y almacenarlo
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Obtener el valor introducido en el TextField
                      String teamName = _teamNameController.text;
                      // TODO cridar funcio josep
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Login!!!',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
