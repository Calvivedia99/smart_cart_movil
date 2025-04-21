import 'package:flutter/material.dart';

class IaScreen extends StatelessWidget {
  const IaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sección de IA'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Pantalla de IA',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}