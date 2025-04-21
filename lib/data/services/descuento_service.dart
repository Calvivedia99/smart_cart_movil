import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/descuento_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class DescuentoService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/descuentos';

  // 🔹 Listar todos los descuentos
  static Future<List<Descuento>> listar() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((e) => Descuento.fromJson(e)).toList();
      }
      throw Exception("Error al listar descuentos: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }

  // 🔹 Obtener un descuento por su ID
  static Future<Descuento> obtener(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id/'));
      if (response.statusCode == 200) {
        return Descuento.fromJson(jsonDecode(response.body));
      }
      throw Exception("Descuento no encontrado: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }

  // 🔹 Crear un nuevo descuento
  static Future<Descuento> crear(Descuento descuento) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(descuento.toJson()),
      );
      if (response.statusCode == 201) {
        return Descuento.fromJson(jsonDecode(response.body));
      }
      throw Exception("Error al crear descuento: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }

  // 🔹 Actualizar un descuento existente
  static Future<Descuento> actualizar(int id, Descuento descuento) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(descuento.toJson()),
      );
      if (response.statusCode == 200) {
        return Descuento.fromJson(jsonDecode(response.body));
      }
      throw Exception("Error al actualizar descuento: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }

  // 🔹 Eliminar un descuento por su ID
  static Future<bool> eliminar(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/eliminar/$id/'));
      if (response.statusCode == 204) {
        return true;
      }
      throw Exception("Error al eliminar descuento: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error de red: $e");
    }
  }
}