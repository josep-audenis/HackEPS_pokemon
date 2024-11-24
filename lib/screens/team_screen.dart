import 'package:flutter/material.dart';
import 'package:lspokedex/providers/team_provider.dart';
import 'package:provider/provider.dart';

class TeamScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: Center(
        child: Text(
          'Hola',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );


  }
}
