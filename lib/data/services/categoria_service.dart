import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/categoria_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class CategoriaService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/categorias';

  // 🔹 Listar todas las categorías
  static Future<List<Categoria>> getAll() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/"));

      print('📦 STATUS: ${response.statusCode}');
      print('📦 BODY: ${response.body}');

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        final List<dynamic> data = jsonBody['data']['categorias']; // ✅ fix

        return data.map((e) => Categoria.fromJson(e)).toList();
      }
      throw Exception("Error al obtener categorías: ${response.statusCode}");
    } catch (e) {
      print('❌ Error en getAll: $e');
      throw Exception("Error de red: $e");
    }
  }

  // 🔹 Obtener una categoría por ID
  static Future<Categoria> getById(int id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/$id/"));
      if (response.statusCode == 200) {
        return Categoria.fromJson(jsonDecode(response.body));
      }
      throw Exception("Categoría no encontrada: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }

  // 🔹 Crear categoría
  static Future<Categoria> create(String name) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/crear/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name}),
      );
      if (response.statusCode == 201) {
        return Categoria.fromJson(jsonDecode(response.body));
      }
      throw Exception("Error al crear categoría: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }

  // 🔹 Actualizar categoría
  static Future<Categoria> update(int id, String name) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/actualizar/$id/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name}),
      );
      if (response.statusCode == 200) {
        return Categoria.fromJson(jsonDecode(response.body));
      }
      throw Exception("Error al actualizar categoría: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }

  // 🔹 Eliminar categoría
  static Future<bool> delete(int id) async {
    try {
      final response = await http.delete(Uri.parse("$_baseUrl/eliminar/$id/"));
      if (response.statusCode == 204) {
        return true;
      }
      throw Exception("Error al eliminar categoría: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }
}
