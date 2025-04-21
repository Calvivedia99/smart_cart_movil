// lib/data/services/producto_service.dart


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/producto_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class ProductoService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/productos';

  // 🔹 Listar todos los productos
  static Future<List<Producto>> getAll() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/"));

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        final List<dynamic> data = jsonBody['data']['productos'];

        return data.map((e) => Producto.fromJson(e)).toList();
      }
      throw Exception("Error al obtener productos: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }
}
