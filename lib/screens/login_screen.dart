import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lspokedex/providers/event_provider.dart';
import 'package:lspokedex/providers/team_provider.dart';
import 'package:lspokedex/utills/constants.dart';
import 'package:provider/provider.dart';
import 'package:lspokedex/screens/pokedex_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _teamNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFFcc544a),
        centerTitle: false,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand, 
        children: [
          Container(
            color: const Color(0xFFcc544a), 
          ),

          Positioned(
            bottom: -100.0, 
            right: -100.0, 
            child: Image.asset(
              'assets/images/pikachu.png',
              width: 500, 
              height: 500, 
            ),
          ),

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
                          'Welcome to Pokedex',
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
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),

                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      String teamName = _teamNameController.text;

                      final teamProvider = Provider.of<TeamProvider>(context, listen: false);
                      final eventProvider = Provider.of<EventProvider>(context, listen: false);
                      bool teamFound = await teamProvider.findAndLoadTeamByName(teamName);
                      if (teamFound) {
                        final team_id = teamProvider.team_id;
                        executeOperationsForLocationsInBackground(eventProvider, team_id!);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PokedexScreen()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context)
                                  .pop(); 
                            });
                            return AlertDialog(
                              content: const Text(
                                'No se encontró un equipo con el nombre proporcionado.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Login',
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


Future<void> executeOperationsForLocationsInBackground(EventProvider eventProvider, String teamId) async {
  await Future.delayed(Duration.zero); 
  await eventProvider.executeOperationsForLocations(teamId);
}