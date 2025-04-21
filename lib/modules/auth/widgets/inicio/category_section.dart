import 'package:flutter/material.dart';
import 'package:smart_cart_movil/data/models/categoria_model.dart';
import 'package:smart_cart_movil/data/services/categoria_service.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  List<Categoria> categorias = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  Future<void> _loadCategorias() async {
    try {
      final response = await CategoriaService.getAll();
      setState(() {
        categorias = response;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("❌ Error cargando categorías: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categorías",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200, // Aumentar el alto para acomodar el tamaño de la imagen
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categorias.length,
                  itemBuilder: (context, index) {
                    final cat = categorias[index];
                    return CategoryCard(
                      title: cat.name,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String? imagePath;

  const CategoryCard({super.key, required this.title, this.imagePath});

  @override
  Widget build(BuildContext context) {
    debugPrint("🟢 Renderizando categoría: $title");

    return Container(
      width: 160, // Aumentar el ancho del contenedor
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
        crossAxisAlignment: CrossAxisAlignment.center, // Centrar horizontalmente
        children: [
          Expanded(
            child: imagePath != null && imagePath!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imagePath!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  )
                : CircleAvatar(
                    radius: 60, // Aumentar el radio del CircleAvatar
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      title.isNotEmpty ? title[0].toUpperCase() : "?",
                      style: const TextStyle(fontSize: 60, color: Colors.black), // Aumentar tamaño de letra
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center, // Centrar texto
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () {
              debugPrint("🔍 Se hizo click en la categoría: $title");
              // TODO: Navegar a vista con productos filtrados por categoría
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 5),
              backgroundColor: Colors.white, // Cambiar a blanco
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Visualizar",
              style: TextStyle(color: Colors.black), // Texto negro para contraste
            ),
          ),
        ],
      ),
    );
  }
}