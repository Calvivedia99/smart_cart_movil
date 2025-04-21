import 'package:flutter/material.dart';

class PedidoScreen extends StatelessWidget {
  const PedidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Pantalla de Pedidos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}