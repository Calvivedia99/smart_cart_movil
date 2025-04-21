// lib/modules/home/widgets/top_products_section.dart
import 'package:flutter/material.dart';
import 'package:smart_cart_movil/data/models/producto_model.dart';
import 'package:smart_cart_movil/data/services/producto_service.dart';
import 'product_card_with_cart.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  List<Producto> productos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductos();
  }

  Future<void> _loadProductos() async {
    try {
      final response = await ProductoService.getAll();
      setState(() {
        productos = response;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("❌ Error cargando productos: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Más Vendidos",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child:
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      return ProductCardWithCart(
                        title: producto.nombre,
                        price: "Bs. ${producto.precio.toString()}",
                        imagePath: producto.urlFoto ?? "",
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
