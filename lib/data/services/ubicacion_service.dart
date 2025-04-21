import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/ubicacion_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class UbicacionService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/ubicaciones';

  // Listar todas las ubicaciones
  static Future<List<Ubicacion>> listar() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((e) => Ubicacion.fromJson(e)).toList();
      } else {
        throw Exception('Error al listar ubicaciones: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Obtener una ubicación por ID
  static Future<Ubicacion?> obtener(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id/'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'];
        return Ubicacion.fromJson(jsonData);
      } else {
        throw Exception('Ubicación no encontrada: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Crear una nueva ubicación
  static Future<bool> crear(Ubicacion ubicacion) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ubicacion.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error al registrar ubicación: $e');
    }
  }

  // Actualizar una ubicación
  static Future<bool> actualizar(int id, Ubicacion ubicacion) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ubicacion.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar ubicación: $e');
    }
  }

  // Eliminar una ubicación
  static Future<bool> eliminar(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/eliminar/$id/'));
      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Error al eliminar ubicación: $e');
    }
  }
}