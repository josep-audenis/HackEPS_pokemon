import 'package:flutter/material.dart';
import 'package:lspokedex/providers/tournament_provider.dart';
import 'package:lspokedex/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';
import 'providers/event_provider.dart';
import 'providers/team_provider.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final eventProvider = EventProvider();
  await eventProvider.loadLocationCodes();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => eventProvider),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
    	ChangeNotifierProvider(create: (_) => TournamentProvider()),
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSPokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
