import 'package:flutter/material.dart';

class ProductCardWithCart extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;

  const ProductCardWithCart({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener la primera letra del título del producto
    String firstLetter = title.isNotEmpty ? title[0].toUpperCase() : "?";

    return Container(
      width: 160, // Ajustamos el ancho para una mejor visualización
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
        crossAxisAlignment: CrossAxisAlignment.center, // Centrar horizontalmente
        children: [
          // Mostrar la imagen o la letra inicial
          imagePath.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imagePath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    firstLetter,
                    style: const TextStyle(fontSize: 40, color: Colors.black),
                  ),
                ),
          const SizedBox(height: 8),
          // Título del producto
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center, // Centrar texto
          ),
          const SizedBox(height: 4),
          // Precio del producto
          Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center, // Centrar texto
          ),
          const SizedBox(height: 8),
          // Botón para añadir al carrito
          TextButton(
            onPressed: () {
              // TODO: Acción para añadir al carrito
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 5),
              backgroundColor: Colors.white, // Cambiar a blanco
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Añadir al Carrito",
              style: TextStyle(color: Colors.black), // Texto negro para contraste
            ),
          ),
        ],
      ),
    );
  }
}